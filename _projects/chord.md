---
layout: project
title: Distributed Network Simulation & P2P Search System
permalink: /projects/chord/
date: January 2025 - May 2025
technologies: C++, NS-3 Network Simulator, Socket Programming, Distributed Systems, DHT (Chord Protocol)
featured: true
---

> A comprehensive network simulation framework implementing dynamic routing protocols and a scalable peer-to-peer search system built on distributed hash table architecture.

## Project Overview

This project implements a complete network simulation environment featuring **dynamic routing protocols** and a **distributed peer-to-peer search application**. Built on the NS-3 network simulator, it demonstrates fundamental concepts in computer networking, distributed systems, and algorithm design through three major components:

1. **Distance Vector (DV) Routing Protocol** - Decentralized routing using the Bellman-Ford algorithm
2. **Link State (LS) Routing Protocol** - Global network view routing using Dijkstra's algorithm  
3. **Penn Search** - Distributed P2P search system built on Chord DHT for scalable document indexing and retrieval

### Key Achievements

- Successfully simulated networks with **40+ nodes** handling dynamic topology changes
- Implemented fault-tolerant routing with automatic convergence on link failures
- Built scalable P2P search supporting **distributed inverted index** across multiple nodes
- Achieved **O(log N)** lookup complexity in the Chord DHT implementation

### Technical Skills

- **Languages & Tools:** C++, NS-3 Network Simulator, Socket Programming, STL containers
- **Networking:** Distance Vector routing (Bellman-Ford), Link State routing (Dijkstra), DHT implementation, P2P systems
- **Algorithms:** Graph algorithms (shortest path), consistent hashing (SHA-1), distributed algorithms, inverted index search
- **Systems:** Event-driven architecture, asynchronous I/O, protocol design, fault-tolerant systems

---

## Component 1: Distance Vector Routing Protocol

### Problem Statement

In dynamic networks, routers need to efficiently compute paths to all destinations without global network knowledge, adapting to topology changes like link failures.

### Solution: Bellman-Ford Algorithm Implementation

**Key Features:**

- **Distributed routing table computation** - Each node maintains distance vectors to all destinations
- **Periodic updates** - Nodes exchange routing information with neighbors
- **Poisoned reverse** - Prevents routing loops by advertising infinite cost to the node that provided the route
- **Split horizon** - Avoids sending routing information back to the source

### Core Algorithm (Pseudocode)

```
// Initialize routing table
function InitializeRoutingTable():
    for each neighbor in neighbors:
        routingTable[neighbor] = directCost(neighbor)
    routingTable[self] = 0

// Periodic update to neighbors
function SendRoutingUpdate():
    for each neighbor in neighbors:
        dvPacket = createDVPacket()
        for each destination in routingTable:
            if routingTable[destination].nextHop == neighbor:
                // Split horizon with poisoned reverse
                dvPacket.add(destination, INFINITY)
            else:
                dvPacket.add(destination, routingTable[destination].cost)
        send(dvPacket, neighbor)

// Process received routing update
function ProcessRoutingUpdate(dvPacket, fromNeighbor):
    updated = false
    for each (destination, cost) in dvPacket:
        newCost = cost + linkCost(fromNeighbor)
        if destination not in routingTable OR newCost < routingTable[destination].cost:
            routingTable[destination] = {cost: newCost, nextHop: fromNeighbor}
            updated = true
        else if routingTable[destination].nextHop == fromNeighbor:
            // Update if path through same neighbor changed
            routingTable[destination].cost = newCost
            updated = true
    
    if updated:
        SendRoutingUpdate()  // Triggered update
```

### Outcomes

- **Fast convergence:** Network converges within seconds after topology changes
- **Loop prevention:** Successfully handles count-to-infinity with poisoned reverse
- **Scalability:** Tested with networks up to 40 nodes with stable routing behavior

---

## Component 2: Link State Routing Protocol

### Problem Statement

Achieve faster convergence and loop-free routing by giving each router complete network topology knowledge.

### Solution: Dijkstra's Shortest Path Algorithm

**Key Features:**

- **Link State Advertisements (LSAs)** - Broadcast network topology information
- **Sequence numbers** - Ensure latest topology information propagates
- **Flooding mechanism** - Reliably distribute LSAs across the network
- **Shortest path computation** - Run Dijkstra's algorithm locally at each node

### Core Algorithm (Pseudocode)

```
// Broadcast link state information
function BroadcastLSA():
    lsa = createLSA()
    lsa.originNode = self
    lsa.sequenceNumber = ++currentSequenceNumber
    
    for each neighbor in neighbors:
        lsa.addLink(neighbor, linkCost(neighbor))
    
    for each neighbor in neighbors:
        forward(lsa, neighbor)
    
    store(lsa)  // Store in local database

// Process received LSA
function ProcessLSA(lsa, fromNeighbor):
    if lsa.sequenceNumber <= storedLSAs[lsa.originNode].sequenceNumber:
        return  // Old LSA, discard
    
    storedLSAs[lsa.originNode] = lsa
    
    // Flood to other neighbors
    for each neighbor in neighbors:
        if neighbor != fromNeighbor:
            forward(lsa, neighbor)
    
    RunDijkstra()  // Recompute routing table

// Dijkstra's shortest path computation
function RunDijkstra():
    unvisited = set(allNodes)
    distance = {self: 0}
    previous = {}
    
    for each node in allNodes:
        if node != self:
            distance[node] = INFINITY
    
    while unvisited is not empty:
        current = node in unvisited with minimum distance[current]
        unvisited.remove(current)
        
        for each neighbor of current from storedLSAs[current]:
            alt = distance[current] + cost(current, neighbor)
            if alt < distance[neighbor]:
                distance[neighbor] = alt
                previous[neighbor] = current
    
    // Build routing table from shortest paths
    BuildRoutingTableFromPaths(previous)
```

### Outcomes

- **Rapid convergence:** Faster than DV protocol due to complete topology knowledge
- **Loop-free routing:** Always computes optimal, loop-free paths
- **Efficient flooding:** LSAs propagate quickly with sequence number control

---

## Component 3: Penn Search - Distributed P2P Search System

### Problem Statement

Build a scalable, decentralized search system where documents are distributed across multiple nodes, allowing efficient keyword-based search without a central server.

### Solution: Chord DHT + Distributed Inverted Index

**Key Features:**

- **Chord DHT overlay network** - O(log N) lookup complexity
- **Distributed inverted index** - Keywords mapped to document lists across nodes
- **Consistent hashing** - SHA-1 based key distribution
- **Fault tolerance** - Graceful handling of node joins/leaves
- **Stabilization protocol** - Maintains correct successor/predecessor relationships
- **Finger table optimization** - Accelerates lookups with exponential distance routing

### Architecture

```
Penn Search Application
    ├── Chord DHT Layer (Overlay Network)
    │   ├── Join/Leave Operations
    │   ├── Stabilization Protocol
    │   ├── Finger Table Maintenance
    │   └── Key Lookup (FindSuccessor)
    └── Search Layer (Application)
        ├── Inverted Index Publishing
        ├── Multi-keyword Search
        └── Result Aggregation
```

### Chord DHT: Core Operations (Pseudocode)

```
// Join the Chord ring
function Join(landmarkNode):
    if landmarkNode == null:
        // First node in ring
        predecessor = null
        successor = self
    else:
        // Ask landmark to find our successor
        successor = landmarkNode.FindSuccessor(hash(self.ipAddress))
        predecessor = null
    
    InitializeFingerTable()
    StartStabilizationTimer()

// Find successor responsible for a key
function FindSuccessor(key):
    if key is between (self, successor]:
        return successor
    else:
        // Forward to closest preceding node
        node = ClosestPrecedingNode(key)
        return node.FindSuccessor(key)

// Find closest preceding node in finger table
function ClosestPrecedingNode(key):
    for i from M down to 1:  // M = 32 (finger table size)
        if fingerTable[i] is between (self, key):
            return fingerTable[i]
    return self

// Stabilization: Maintain correct successor
function Stabilize():
    x = successor.GetPredecessor()
    if x is between (self, successor):
        successor = x
    successor.Notify(self)

// Fix finger table entries incrementally
function FixFingers():
    nextFingerIndex = (nextFingerIndex + 1) % M
    fingerTable[nextFingerIndex] = FindSuccessor(self + 2^nextFingerIndex)

// Handle notification from potential predecessor
function Notify(node):
    if predecessor == null OR node is between (predecessor, self):
        predecessor = node
```

### Penn Search: Inverted Index & Search (Pseudocode)

```
// Publish document metadata (inverted index)
function PublishInvertedList(metadataFile):
    documents = ParseMetadata(metadataFile)
    
    for each document in documents:
        for each keyword in document.keywords:
            keywordHash = SHA1(keyword)
            responsibleNode = FindSuccessor(keywordHash)
            
            invertedList = {keyword: keyword, docs: [document.id]}
            SendInvertedList(responsibleNode, invertedList)

// Store inverted list at responsible node
function ReceiveInvertedList(keyword, documentList):
    if keyword in localDatabase:
        localDatabase[keyword].append(documentList)
    else:
        localDatabase[keyword] = documentList

// Multi-keyword search
function Search(keywords[]):
    transactionId = getNextTransactionId()
    searchTracker[transactionId] = {
        keywords: keywords,
        results: {},
        pending: keywords.length
    }
    
    for each keyword in keywords:
        keywordHash = SHA1(keyword)
        responsibleNode = FindSuccessor(keywordHash)
        SendSearchRequest(responsibleNode, keyword, transactionId)

// Process search response and aggregate results
function ProcessSearchResponse(keyword, documentList, transactionId):
    tracker = searchTracker[transactionId]
    tracker.results[keyword] = documentList
    tracker.pending--
    
    if tracker.pending == 0:
        // All results received, compute intersection
        finalResults = tracker.results[tracker.keywords[0]]
        for i from 1 to tracker.keywords.length - 1:
            finalResults = Intersection(finalResults, 
                                      tracker.results[tracker.keywords[i]])
        
        DisplayResults(finalResults)

// Compute intersection of document lists
function Intersection(list1, list2):
    result = []
    for each doc in list1:
        if doc in list2:
            result.append(doc)
    return result
```

### Key Transfer on Node Dynamics (Pseudocode)

```
// Graceful leave: Transfer keys to successor
function Leave():
    keysToTransfer = []
    
    for each (keyword, docList) in localDatabase:
        keysToTransfer.append({keyword: keyword, docs: docList})
    
    SendPassKeys(successor, keysToTransfer)
    successor.predecessor = predecessor
    predecessor.successor = successor

// Receive keys when predecessor leaves
function ReceivePassedKeys(keysToTransfer):
    for each entry in keysToTransfer:
        if entry.keyword in localDatabase:
            localDatabase[entry.keyword].extend(entry.docs)
        else:
            localDatabase[entry.keyword] = entry.docs
```

### Outcomes

- **Logarithmic lookup:** O(log N) hops to find responsible node in N-node network
- **Load balancing:** Consistent hashing distributes keys evenly across nodes
- **Fault tolerance:** System remains operational during node joins/leaves with key transfer
- **Multi-keyword search:** Efficiently handles complex queries through result intersection
- **Scalability:** Successfully tested with 10+ node networks with multiple documents per node

---

## Testing & Results

### Performance Metrics

**Distance Vector Protocol:**

- Average convergence time: 2-5 seconds after topology change
- Memory overhead: O(N²) for N nodes (routing table storage)
- Message complexity: O(N²) periodic updates

**Link State Protocol:**

- Average convergence time: 1-3 seconds after topology change
- Memory overhead: O(N²) (complete topology database)
- Message complexity: O(N·E) for LSA flooding (N nodes, E edges)

**Chord DHT:**

- Lookup hops: Average 3-4 hops in 10-node network (consistent with O(log N))
- Join time: 2-5 seconds including stabilization
- Finger table accuracy: >95% after stabilization period


## Key Takeaways

This project provided hands-on experience with:

1. **Real-world networking protocols:** Implemented actual routing algorithms used in production networks
2. **Distributed systems design:** Built a complete P2P system from scratch with fault tolerance
3. **Large-scale C++ development:** Managed a complex codebase with multiple interacting components
4. **Algorithm implementation:** Translated theoretical algorithms into working code
5. **Performance analysis:** Evaluated protocol behavior under various network conditions

The experience gained from this project is directly applicable to building scalable backend systems, distributed databases, and networked applications in industry.

---

## Course Context

**Course:** CIS 5530 - Networked Systems, University of Pennsylvania  
**Semester:** Spring 2025  
**Topics Covered:** TCP/IP networking, routing protocols, distributed hash tables, P2P systems

---

*This project demonstrates proficiency in systems programming, distributed algorithms, and network protocol implementation - skills essential for backend engineering, infrastructure development, and distributed systems roles.*

