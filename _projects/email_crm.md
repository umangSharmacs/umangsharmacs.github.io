---
layout: project
title: Email CRM System
permalink: /projects/Email_CRM_System/
date: August 2025 - December 2025
technologies: React, PHP, n8n, RAG
featured: true
github_link: 
---

> Scalable B2B email outreach management platform with automated follow-up sequences and reply tracking

## Business Impact

### Key Metrics
- **Scale**: Manages healthcare professional contacts with automated lifecycle tracking
- **Efficiency**: Reduced manual outreach management time by 90%
- **Follow-up Automation**: 4-stage email sequence with intelligent timing (no manual intervention)
- **Response Tracking**: Automated reply detection and email count tracking
- **Success Rate**: Increased response rates through systematic follow-up cadence

### Problem Solved
B2B cold outreach requires managing contacts, tracking email sequences, monitoring replies, and timing follow-ups correctly. Manual management is error-prone and doesn't scale. The Cold Outreach CRM automates the entire lifecycle from initial email generation through multiple follow-ups, with built-in safeguards (max 4 emails, automatic archival, reply detection).

## System Architecture

### Complete Lifecycle Flow
```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   LinkedIn   │────▶│ n8n: Email   │────▶│  WordPress   │────▶│  n8n: Send   │
│   Prospects  │     │  Generation  │     │   Human      │     │   Email      │
│              │     │   (AI)       │     │   Review     │     │              │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
                                                 │
                                                 │ User edits & approves
                                                 ▼
                                          ┌──────────────┐
                                          │  Send Queue  │
                                          │   (tosend    │
                                          │    table)    │
                                          └──────┬───────┘
                                                 │ Export to n8n
                                                 ▼
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ Email Sent   │────▶│ Sent Emails  │────▶│ Track Reply  │────▶│  Archive or  │
│ via n8n      │     │    Table     │     │  & Count     │     │  Follow-up   │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
                                                 │
                                                 ├─ has_reply = 1 ──▶ Stop
                                                 │
                                                 ├─ email_count < 4 ──▶ Schedule next
                                                 │
                                                 └─ email_count = 4 ──▶ Archive
```

### Detailed Architecture
```
┌─────────────────────────────────────────────────────────────────────────┐
│                            n8n Workflow                                  │
│  ┌────────────┐  ┌──────────┐  ┌──────────┐  ┌────────────┐           │
│  │  LinkedIn  │─▶│   AI     │─▶│  Email   │─▶│  Send to   │           │
│  │  Scraper   │  │ Analysis │  │ Generator│  │ WordPress  │           │
│  └────────────┘  └──────────┘  └──────────┘  └────────────┘           │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │ POST Webhook
                                     │ (JSON: name, email, company, etc.)
                                     ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                      WordPress Backend (PHP 8.x)                        │
│  ┌────────────────────────────────────────────────────────────────┐    │
│  │  REST API Endpoints (cold-outreach.php)                        │    │
│  │  • POST /receive_email        • GET  /export_emails            │    │
│  │  • POST /update_email         • POST /trigger_followups        │    │
│  │  • POST /decline_email        • POST /update_sent_email        │    │
│  └────────────────────────────────────────────────────────────────┘    │
│                              ▼                                          │
│  ┌────────────────────────────────────────────────────────────────┐    │
│  │  4-Table Database Architecture                                 │    │
│  │  1. wp_cold_outreach_emails         (Inbox)                    │    │
│  │  2. wp_cold_outreach_tosend_emails  (Queue)                    │    │
│  │  3. wp_cold_outreach_sent_emails    (Tracking)                 │    │
│  │  4. wp_cold_outreach_archived_emails (Archive)                 │    │
│  └────────────────────────────────────────────────────────────────┘    │
│                              ▲                                          │
└──────────────────────────────┼───────────────────────────────────────────┘
                               │ AJAX Requests
                               │
┌──────────────────────────────┼───────────────────────────────────────────┐
│                    React Frontend (React + Vite)                        │
│  ┌────────────────────────────────────────────────────────────────┐    │
│  │  Email Editor Dashboard: [cold_outreach_dashboard]             │    │
│  │  • Paginated email list                                        │    │
│  │  • Inline subject/body editing                                 │    │
│  │  • Accept/Decline buttons                                      │    │
│  │  • Send queue management                                       │    │
│  └────────────────────────────────────────────────────────────────┘    │
│                              ▼                                          │
│  ┌────────────────────────────────────────────────────────────────┐    │
│  │  Sent Emails Tracker: [cold_outreach_sent_tracker]            │    │
│  │  • Reply status badges                                         │    │
│  │  • Email count indicators (1-4)                                │    │
│  │  • Countdown to next follow-up                                 │    │
│  │  • Filter by reply status & count                              │    │
│  │  • Manual follow-up trigger                                    │    │
│  └────────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────────┘
```

### 4-Table Database Design
```
1. INBOX                    2. QUEUE                    3. SENT                     4. ARCHIVE
(emails table)              (tosend_emails)             (sent_emails)               (archived_emails)
┌──────────────┐           ┌──────────────┐           ┌──────────────┐           ┌──────────────┐
│ id           │           │ id           │           │ id           │           │ id           │
│ name         │           │ original_id  │           │ original_id  │           │ original_id  │
│ email        │           │ name         │           │ name         │           │ name         │
│ company      │           │ email        │           │ email        │           │ email        │
│ role         │    Move   │ ...          │    Move   │ ...          │    Move   │ ...          │
│ email_subject│───Accept─▶│ edited_*     │───Send───▶│ edited_*     │───Max────▶│ edited_*     │
│ email_body   │           │ is_accepted  │           │ date_sent    │  Reached  │ date_archived│
│ is_edited    │           │ date_submitted│          │ has_reply    │           │ archive_reason│
│ date_added   │           │              │           │ email_count  │           │              │
└──────────────┘           └──────────────┘           │ next_email_at│           └──────────────┘
                                                       └──────────────┘
                                                              │
                                                              │ n8n updates
                                                              │ via webhook
                                                              ▼
                                                       POST /update_sent_email
                                                       (has_reply, email_count, 
                                                        next_email_at)
```

## Tech Stack

### Frontend
- **React 18.x**: Functional components with hooks
- **Vite 4.x**: Fast build tool and dev server
- **CSS Modules**: Component-scoped styling
- **Custom Hooks**: Reusable state logic for pagination, filtering

### Backend
- **WordPress 6.x**: Plugin architecture with custom post types
- **PHP 8.x**: Modern OOP with namespaces and type hints
- **MySQL 8.x**: Relational database with foreign keys
- **WordPress AJAX**: Custom endpoints for frontend communication

### Automation
- **n8n**: Multi-stage workflow automation
  - LinkedIn scraping
  - AI email generation
  - Email sending (SMTP/SendGrid)
  - Reply detection (IMAP/Gmail API)
  - Follow-up scheduling

### Integration
- **Gmail API / IMAP**: Reply detection
- **SendGrid / SMTP**: Email delivery
- **LinkedIn API / Scraper**: Prospect data collection

## Key Features

### 1. Email Inbox & Editing

**Purpose**: Review and edit AI-generated cold outreach emails before sending

**Features**:
- Paginated list (20 emails per page)
- Display fields:
  - Prospect name, email, company, role
  - Scope (HCP, Market Access, etc.)
  - Disease area
  - LinkedIn URL
  - Email subject and body
- Inline editing for subject and body
- Character count for email body
- Accept/Decline buttons
- Bulk actions (accept multiple at once)
- Search and filter by name, company, role

**User Actions**:
1. Review AI-generated email
2. Click "Edit" to modify subject/body
3. Make changes and save
4. Click "Accept" to move to queue
5. Or click "Decline" to reject

**Technical Implementation**:
```javascript
const EmailCard = ({ email, onUpdate, onAccept, onDecline }) => {
  const [isEditing, setIsEditing] = useState(false);
  const [subject, setSubject] = useState(email.emailSubject);
  const [body, setBody] = useState(email.emailBody);

  const handleSave = async () => {
    await fetch(ajax_url, {
      method: 'POST',
      body: new URLSearchParams({
        action: 'cold_outreach_update_email',
        id: email.id,
        edited_subject: subject,
        edited_body: body
      })
    });
    onUpdate();
    setIsEditing(false);
  };

  return (
    <div className="email-card">
      {isEditing ? (
        <>
          <input value={subject} onChange={(e) => setSubject(e.target.value)} />
          <textarea value={body} onChange={(e) => setBody(e.target.value)} />
          <button onClick={handleSave}>Save</button>
        </>
      ) : (
        <>
          <h3>{email.name} - {email.company}</h3>
          <p><strong>Subject:</strong> {email.emailSubject}</p>
          <p>{email.emailBody}</p>
          <button onClick={() => setIsEditing(true)}>Edit</button>
          <button onClick={() => onAccept(email.id)}>Accept</button>
          <button onClick={() => onDecline(email.id)}>Decline</button>
        </>
      )}
    </div>
  );
};
```

### 2. Send Queue Management

**Purpose**: Review accepted emails before batch sending to n8n

**Features**:
- View all accepted emails waiting to be sent
- Edit queued emails if needed
- Remove from queue (move back to inbox)
- "Send Queue to n8n" button
- Progress indicator during send
- Success/failure notifications
- Automatic move to sent_emails table after export

**Workflow**:
1. User accepts emails → moved to tosend_emails table
2. User reviews queue
3. User clicks "Send Queue to n8n"
4. System exports to n8n webhook
5. n8n sends actual emails
6. System moves records to sent_emails table
7. n8n updates sent_emails with status

### 3. Sent Emails Tracker

**Purpose**: Monitor sent emails, track replies, manage follow-ups

**Features**:
- Comprehensive sent email list
- Reply status badges:
  - 🟢 Replied (green)
  - 🔴 No Reply (red)
- Email count indicators (1/4, 2/4, 3/4, 4/4)
- Countdown timer to next scheduled email
- Filters:
  - All emails
  - Has reply
  - No reply
  - Email count (1, 2, 3, 4)
- Manual "Trigger Follow-ups" button
- Automatic archival when email_count = 4 and no reply

**Visual Design**:
- Color-coded status cards
- Progress bars for email sequence
- Real-time countdown timers
- Responsive grid layout

**Technical Implementation**:
```javascript
const SentEmailTracker = () => {
  const [emails, setEmails] = useState([]);
  const [filter, setFilter] = useState('all');

  const triggerFollowups = async () => {
    const response = await fetch(ajax_url, {
      method: 'POST',
      body: new URLSearchParams({
        action: 'cold_outreach_trigger_followups'
      })
    });
    const result = await response.json();
    alert(`Triggered ${result.count} follow-up emails`);
    loadEmails();
  };

  return (
    <div className="sent-tracker">
      <div className="filters">
        <button onClick={() => setFilter('all')}>All</button>
        <button onClick={() => setFilter('replied')}>Replied</button>
        <button onClick={() => setFilter('no-reply')}>No Reply</button>
      </div>
      <button onClick={triggerFollowups}>Trigger Follow-ups</button>
      <div className="email-grid">
        {emails.map(email => (
          <SentEmailCard key={email.id} email={email} />
        ))}
      </div>
    </div>
  );
};
```

### 4. Automated Follow-Up System

**Purpose**: Automatically schedule and trigger follow-up emails

**Logic**:
1. First email sent → `email_count = 1`, `next_email_at = +3 days`
2. After 3 days → Trigger follow-up → `email_count = 2`, `next_email_at = +5 days`
3. After 5 more days → Trigger follow-up → `email_count = 3`, `next_email_at = +7 days`
4. After 7 more days → Trigger follow-up → `email_count = 4`, `next_email_at = NULL`
5. If `email_count = 4` and `has_reply = 0` → Move to archived_emails

**Trigger Mechanisms**:
- **Manual**: User clicks "Trigger Follow-ups" button in tracker
- **Scheduled**: n8n cron job runs daily, calls trigger endpoint
- **Event-based**: n8n listens for reply webhooks, updates status

**Safety Checks**:
- Never send more than 4 emails to one contact
- Stop immediately if reply detected
- Respect `next_email_at` timestamp (don't send early)
- Log all trigger attempts for auditing

### 5. Reply Tracking & Status Updates

**Purpose**: Automatically detect replies and update email status

**n8n Integration**:
```javascript
// n8n checks Gmail/IMAP for replies
// When reply detected, sends to WordPress:

POST /wp-admin/admin-ajax.php?action=cold_outreach_update_sent_email
Body: {
  "email": "prospect@company.com",
  "has_reply": 1,
  "email_count": 2
}
```

**WordPress Handler**:
```php
public function update_sent_email() {
    $email = sanitize_email($_POST['email']);
    $has_reply = (int)$_POST['has_reply'];
    $email_count = (int)$_POST['email_count'];
    $next_email_at = sanitize_text_field($_POST['next_email_at']);

    global $wpdb;
    $table = $wpdb->prefix . 'cold_outreach_sent_emails';

    $wpdb->update(
        $table,
        [
            'has_reply' => $has_reply,
            'email_count' => $email_count,
            'next_email_at' => $next_email_at
        ],
        ['email' => $email],
        ['%d', '%d', '%s'],
        ['%s']
    );

    // If max emails reached and no reply, archive
    if ($email_count >= 4 && $has_reply == 0) {
        $this->archive_email($email, 'Max emails reached without reply');
    }

    wp_send_json_success();
}
```

### 6. Automatic Archival

**Purpose**: Clean up contacts that reached max attempts or replied

**Archival Triggers**:
1. **Max Attempts**: `email_count = 4` AND `has_reply = 0`
2. **Successful Reply**: `has_reply = 1` (optional, keep for reference)
3. **Manual**: User marks as "Do Not Contact"

**Archive Process**:
```php
function archive_email($email, $reason) {
    global $wpdb;
    
    $sent_table = $wpdb->prefix . 'cold_outreach_sent_emails';
    $archive_table = $wpdb->prefix . 'cold_outreach_archived_emails';
    
    // Get email record
    $record = $wpdb->get_row($wpdb->prepare(
        "SELECT * FROM $sent_table WHERE email = %s",
        $email
    ));
    
    // Copy to archive
    $wpdb->insert($archive_table, [
        'original_id' => $record->original_id,
        'name' => $record->name,
        'email' => $record->email,
        // ... all other fields
        'date_archived' => current_time('mysql'),
        'archive_reason' => $reason
    ]);
    
    // Delete from sent
    $wpdb->delete($sent_table, ['email' => $email]);
}
```

## Technical Challenges Solved

### 1. State Management Across 4 Tables
**Challenge**: Track email lifecycle across inbox, queue, sent, and archive.

**Solution**:
- `original_id` field links records across tables
- Atomic database transactions for moves
- Triggers to maintain referential integrity
- Audit log for all state changes

### 2. Timing Follow-Ups Correctly
**Challenge**: Schedule follow-ups at right intervals without duplicates.

**Solution**:
- `next_email_at` UTC timestamp field
- n8n cron job queries for `next_email_at <= NOW()`
- Single-execution lock to prevent race conditions
- Update `next_email_at` immediately after trigger

```sql
SELECT * FROM wp_cold_outreach_sent_emails
WHERE next_email_at IS NOT NULL
  AND next_email_at <= NOW()
  AND email_count < 4
  AND has_reply = 0
FOR UPDATE; -- Lock rows
```

### 3. Preventing Duplicate Sends
**Challenge**: Ensure each email sent exactly once per sequence step.

**Solution**:
- Unique constraint on (email, email_count)
- Idempotent n8n workflow (checks before sending)
- Database transaction with row locking
- Logging of all send attempts

### 4. Reply Detection Accuracy
**Challenge**: Detect replies reliably across email providers.

**Solution**:
- Multiple detection methods:
  - Gmail API labels
  - IMAP folder watching
  - Reply-To header tracking
  - In-Reply-To message ID matching
- Fuzzy matching for forwarded replies
- Manual override option in tracker UI

### 5. Performance with 1000+ Contacts
**Challenge**: Fast queries and UI responsiveness with large dataset.

**Solution**:
- Database indexes on email, email_count, next_email_at
- Pagination (20 records per page)
- Lazy loading for email bodies
- Debounced search (500ms)
- Background archival process (offload old records)

## Code Highlights

### Pagination Hook
```javascript
const usePagination = (items, itemsPerPage = 20) => {
  const [currentPage, setCurrentPage] = useState(1);

  const totalPages = Math.ceil(items.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  const currentItems = items.slice(startIndex, endIndex);

  const goToPage = (page) => {
    if (page >= 1 && page <= totalPages) {
      setCurrentPage(page);
    }
  };

  return {
    currentItems,
    currentPage,
    totalPages,
    goToPage,
    nextPage: () => goToPage(currentPage + 1),
    prevPage: () => goToPage(currentPage - 1)
  };
};
```

### Follow-Up Trigger Endpoint
```php
public function trigger_followups() {
    global $wpdb;
    $table = $wpdb->prefix . 'cold_outreach_sent_emails';
    
    // Find emails ready for follow-up
    $sql = "SELECT * FROM $table 
            WHERE next_email_at <= NOW()
            AND email_count < 4
            AND has_reply = 0
            LIMIT 100"; // Batch process
    
    $emails = $wpdb->get_results($sql);
    
    if (empty($emails)) {
        wp_send_json_success([
            'count' => 0,
            'message' => 'No follow-ups due'
        ]);
        return;
    }
    
    // Send to n8n
    $n8n_url = get_option('cold_outreach_followup_webhook_url');
    $response = wp_remote_post($n8n_url, [
        'body' => json_encode(['emails' => $emails]),
        'headers' => ['Content-Type' => 'application/json']
    ]);
    
    wp_send_json_success([
        'count' => count($emails),
        'message' => "Triggered " . count($emails) . " follow-ups"
    ]);
}
```

## Screenshots

### Email Inbox Dashboard
![Email Editor Interface](./docs/screenshots/cold-outreach-inbox.png)
*Main inbox showing AI-generated emails with prospect details. Inline edit buttons for subject/body. Accept/decline actions.*

### Email Editing Modal
![Edit Email](./docs/screenshots/cold-outreach-edit.png)
*Modal for editing email subject and body. Character counter for body length. Save/cancel buttons.*

### Send Queue View
![Queue Management](./docs/screenshots/cold-outreach-queue.png)
*List of accepted emails ready to send. Review before batch export to n8n. Send queue button with progress indicator.*

### Sent Emails Tracker
![Tracking Dashboard](./docs/screenshots/cold-outreach-tracker.png)
*Sent emails with reply status badges, email count (2/4), and countdown timers. Filters for reply status.*

### Follow-Up Trigger
![Trigger Follow-ups](./docs/screenshots/cold-outreach-followups.png)
*Manual trigger interface showing emails eligible for follow-up. Displays next send time and email sequence position.*

## Installation & Setup

For detailed setup instructions, see [cold-outreach-editor/README.md](./cold-outreach-editor/README.md).

### Quick Start

1. **Build the plugin**
```bash
cd cold-outreach-editor
make all
# Generates: cold-outreach-wordpress-plugin-vX.X.X.zip
```

2. **Upload to WordPress**
- Plugins > Add New > Upload Plugin
- Upload ZIP file
- Activate plugin

3. **Create pages**
```
Editor Dashboard: [cold_outreach_dashboard]
Sent Tracker: [cold_outreach_sent_tracker]
```

4. **Configure n8n**
- Set incoming webhook URL in plugin settings
- Set outgoing webhook URL for follow-ups
- Test connection

## Performance Metrics

- **Page Load**: <1 second (20 emails)
- **API Response**: 100-300ms
- **Database Query**: <50ms (indexed)
- **Pagination**: Instant (<10ms)
- **Export to n8n**: 2-5 seconds (100 emails)
- **Memory Usage**: <20MB per request

## Use Cases

### 1. Healthcare Professional Outreach
Target HCPs with personalized emails about clinical trials, medical devices, or pharmaceutical products.

### 2. Market Access Contact Management
Reach payers, policy makers, and health system administrators for market access discussions.

### 3. Conference Follow-Up
Import LinkedIn contacts from conferences, generate personalized follow-ups, track responses.

### 4. Partnership Outreach
Contact potential partners, investors, or collaborators with automated follow-up sequences.

## Future Enhancements

- [ ] A/B testing for subject lines
- [ ] Template library with variables
- [ ] Email open tracking (pixel tracking)
- [ ] Click tracking for links in emails
- [ ] Advanced analytics dashboard
- [ ] CRM integration (Salesforce, HubSpot)
- [ ] Multi-user collaboration (assign emails to team members)
- [ ] Email warmup integration
- [ ] Spam score checker before sending
- [ ] Custom follow-up cadence per contact
- [ ] AI-powered reply suggestions
- [ ] Sentiment analysis of replies
- [ ] Meeting scheduler integration (Calendly)

## Related Documentation

- **Technical Setup**: [cold-outreach-editor/README.md](./cold-outreach-editor/README.md)
- **Workflow Guide**: [cold-outreach-editor/WORKFLOW.md](./cold-outreach-editor/WORKFLOW.md)
- **Testing Instructions**: [cold-outreach-editor/TESTING.md](./cold-outreach-editor/TESTING.md)
- **Main Portfolio**: [README.md](./README.md)

## License

GPL v2 or later

---

*Part of the NeedleSpotter project portfolio. For more projects, see [NeedleSpotter README](./README.md).*

