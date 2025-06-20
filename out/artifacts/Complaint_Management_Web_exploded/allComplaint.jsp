<%@ page import="org.example.dto.ComplaintsDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Complaints - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
    <style>
        /* [Previous CSS unchanged, included for completeness] */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #000000 0%, #171717 50%, #000000 100%);
            min-height: 100vh;
            color: #e0e0e0;
            overflow-x: hidden;
        }

        /* Header */
        .header {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 140, 0, 0.2);
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            color: #000;
            box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
        }

        .logo-text {
            font-size: 24px;
            font-weight: 700;
            color: #ff8c00;
            text-shadow: 0 0 10px rgba(255, 140, 0, 0.3);
        }

        /* Main Content */
        .main-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .page-title {
            text-align: center;
            margin-bottom: 40px;
        }

        .page-title h1 {
            font-size: 36px;
            font-weight: 700;
            color: #ff8c00;
            margin-bottom: 10px;
            text-shadow: 0 0 20px rgba(255, 140, 0, 0.4);
        }

        .page-title p {
            font-size: 18px;
            color: #b0b0b0;
            font-weight: 400;
        }

        /* Controls Section */
        .controls-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            gap: 20px;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            max-width: 400px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 15px 20px 15px 50px;
            background: rgba(30, 30, 30, 0.95);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 12px;
            color: #e0e0e0;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #ff8c00;
            box-shadow: 0 0 20px rgba(255, 140, 0, 0.2);
        }

        .search-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #ff8c00;
            font-size: 18px;
        }

        .filter-section {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .filter-select {
            padding: 10px 15px;
            background: rgba(30, 30, 30, 0.95);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 8px;
            color: #e0e0e0;
            font-size: 14px;
            cursor: pointer;
        }

        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: #ff8c00;
            text-decoration: none;
            font-weight: 600;
            padding: 10px 15px;
            border-radius: 8px;
            background: rgba(255, 140, 0, 0.1);
            border: 1px solid rgba(255, 140, 0, 0.3);
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: rgba(255, 140, 0, 0.2);
            transform: translateX(-5px);
        }

        .filter-select:focus {
            outline: none;
            border-color: #ff8c00;
        }

        /* Stats Bar */
        .stats-bar {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-item {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            border: 1px solid rgba(255, 140, 0, 0.2);
            transition: all 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        }

        .stat-number {
            font-size: 24px;
            font-weight: 700;
            color: #ff8c00;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #b0b0b0;
            font-size: 12px;
            font-weight: 500;
        }

        /* Anonymous Badge */
        .anonymous-badge {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-left: 8px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        /* Complaints Grid */
        .complaints-container {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(255, 140, 0, 0.2);
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .complaints-grid {
            display: grid;
            gap: 0;
        }

        .complaint-card {
            padding: 25px;
            border-bottom: 1px solid rgba(255, 140, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 20px;
            align-items: center;
        }

        .complaint-card:hover {
            background: rgba(255, 140, 0, 0.05);
            transform: translateX(5px);
        }

        .complaint-card:last-child {
            border-bottom: none;
        }

        .complaint-info {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 20px;
            align-items: center;
        }

        .complaint-main {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .complaint-title {
            font-size: 18px;
            font-weight: 600;
            color: #e0e0e0;
            margin-bottom: 5px;
        }

        .complaint-meta {
            display: flex;
            gap: 15px;
            font-size: 13px;
            color: #888;
            align-items: center;
        }

        .complaint-user {
            color: #888;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .complaint-date {
            color: #888;
        }

        .complaint-status {
            text-align: center;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        .status-in-progress {
            background: rgba(33, 150, 243, 0.2);
            color: #2196f3;
            border: 1px solid rgba(33, 150, 243, 0.3);
        }

        .status-resolved {
            background: rgba(76, 175, 80, 0.2);
            color: #4caf50;
            border: 1px solid rgba(76, 175, 80, 0.3);
        }

        .status-rejected {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        .complaint-priority {
            text-align: center;
        }

        .priority-badge {
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .priority-high {
            background: rgba(244, 67, 54, 0.2);
            color: #f44336;
        }

        .priority-medium {
            background: rgba(255, 152, 0, 0.2);
            color: #ff9800;
        }

        .priority-low {
            background: rgba(76, 175, 80, 0.2);
            color: #4caf50;
        }

        .complaint-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 8px 15px;
            border: none;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-edit {
            background: linear-gradient(135deg, #2196f3 0%, #1976d2 100%);
            color: white;
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(33, 150, 243, 0.4);
        }

        .btn-delete {
            background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
            color: white;
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(244, 67, 54, 0.4);
        }

        .btn-view {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
        }

        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 140, 0, 0.4);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(5px);
            overflow-y: auto;
        }

        .modal-content {
            background: rgba(30, 30, 30, 0.98);
            margin: 3% auto;
            padding: 30px;
            border-radius: 20px;
            width: 90%;
            max-width: 700px;
            border: 1px solid rgba(255, 140, 0, 0.3);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            max-height: 90vh;
            overflow-y: auto;
        }

        /* View Modal Specific Styles */
        .complaint-details {
            max-height: 60vh;
            overflow-y: auto;
        }

        .detail-section {
            margin-bottom: 25px;
            padding: 20px;
            background: rgba(40, 40, 40, 0.3);
            border-radius: 12px;
            border: 1px solid rgba(255, 140, 0, 0.1);
        }

        .detail-title {
            color: #ff8c00;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .detail-label {
            font-size: 12px;
            color: #888;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-value {
            font-size: 14px;
            color: #e0e0e0;
            font-weight: 500;
        }

        .detail-description, .detail-remarks {
            background: rgba(50, 50, 50, 0.5);
            padding: 15px;
            border-radius: 8px;
            color: #e0e0e0;
            line-height: 1.6;
            min-height: 60px;
            border: 1px solid rgba(255, 140, 0, 0.1);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .modal-title {
            color: #ff8c00;
            font-size: 24px;
            font-weight: 700;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s;
        }

        .close:hover {
            color: #ff8c00;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #e0e0e0;
            font-weight: 600;
        }

        .form-select, .form-textarea {
            width: 100%;
            padding: 12px;
            background: rgba(40, 40, 40, 0.8);
            border: 2px solid rgba(255, 140, 0, 0.3);
            border-radius: 8px;
            color: #e0e0e0;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: #ff8c00;
        }

        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }

        .modal-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 140, 0, 0.4);
        }

        .btn-secondary {
            background: transparent;
            color: #888;
            padding: 12px 25px;
            border: 2px solid #555;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            border-color: #777;
            color: #aaa;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .complaint-info {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .complaint-card {
                grid-template-columns: 1fr;
                gap: 15px;
            }
        }

        @media (max-width: 768px) {
            .controls-section {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                max-width: none;
            }

            .stats-bar {
                grid-template-columns: repeat(2, 1fr);
            }

            .complaint-actions {
                justify-content: center;
            }

            .modal-content {
                margin: 10% auto;
                width: 95%;
            }
        }

        /* Loading animation */
        .loading {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid rgba(255, 140, 0, 0.3);
            border-left: 4px solid #ff8c00;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .complaint-card {
            animation: fadeInUp 0.5s ease-out;
        }

        .complaint-card:nth-child(odd) { animation-delay: 0.1s; }
        .complaint-card:nth-child(even) { animation-delay: 0.15s; }
    </style>
</head>
<body>
<!-- Header -->
<header class="header">
    <div class="header-content">
        <div class="logo">
            <div class="logo-icon">A</div>
            <div class="logo-text">Admin Portal</div>
        </div>
        <div class="actions-bar">
            <a href="adminDashboard.jsp" class="back-link">
                ← Back to Dashboard
            </a>
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="main-content">
    <!-- Page Title -->
    <div class="page-title">
        <h1>All Complaints</h1>
        <p>Manage and track all anonymous employee complaints</p>
    </div>

    <!-- Stats Bar -->
    <div class="stats-bar">
        <div class="stat-item">
            <div class="stat-number" id="totalComplaints">4</div>
            <div class="stat-label">Total Complaints</div>
        </div>
        <div class="stat-item">
            <div class="stat-number" id="pendingCount">2</div>
            <div class="stat-label">Pending</div>
        </div>
        <div class="stat-item">
            <div class="stat-number" id="progressCount">1</div>
            <div class="stat-label">In Progress</div>
        </div>
        <div class="stat-item">
            <div class="stat-number" id="resolvedCount">1</div>
            <div class="stat-label">Resolved</div>
        </div>
    </div>

    <!-- Controls Section -->
    <div class="controls-section">
        <div class="search-box">
            <span class="search-icon">🔍</span>
            <input type="text" class="search-input" placeholder="Search complaints by title or description...">
        </div>
        <div class="filter-section">
            <select class="filter-select" id="statusFilter">
                <option value="">All Status</option>
                <option value="PENDING">Pending</option>
                <option value="IN_PROGRESS">In Progress</option>
                <option value="RESOLVED">Resolved</option>
                <option value="REJECTED">Rejected</option>
            </select>
            <select class="filter-select" id="priorityFilter">
                <option value="">All Priority</option>
                <option value="high">High</option>
                <option value="medium">Medium</option>
                <option value="low">Low</option>
            </select>
        </div>
    </div>

    <!-- Complaints Container -->
    <div class="complaints-container">
        <div class="complaints-grid" id="complaintsGrid">
            <%
                List<ComplaintsDTO> complaints = (List<ComplaintsDTO>) request.getAttribute("complaints");
                if (complaints == null || complaints.isEmpty()) {
            %>
            <div class="empty-state" style="text-align: center; padding: 40px;">
                <div class="empty-icon" style="font-size: 48px; color: #888;">📭</div>
                <h3 style="color: #e0e0e0; font-size: 24px; margin: 20px 0;">No Complaints Found</h3>
                <p style="color: #b0b0b0; font-size: 16px;">There are no complaints to display at the moment.</p>
            </div>
            <%
            } else {
                for (ComplaintsDTO complaint : complaints) {
                    String statusClass = "";
                    String statusIcon = "";
                    switch (complaint.getStatus().toUpperCase()) {
                        case "PENDING":
                            statusClass = "status-pending";
                            statusIcon = "⏳";
                            break;
                        case "IN_PROGRESS":
                            statusClass = "status-in-progress";
                            statusIcon = "🔄";
                            break;
                        case "RESOLVED":
                            statusClass = "status-resolved";
                            statusIcon = "✅";
                            break;
                        case "REJECTED":
                            statusClass = "status-rejected";
                            statusIcon = "❌";
                            break;
                    }
            %>
            <div class="complaint-card"
                 data-id="<%= complaint.getComplaint_id() %>"
                 data-status="<%= complaint.getStatus().toUpperCase() %>"
                 data-priority="<%= complaint.getPriority().toLowerCase() %>"
                 data-description="<%= complaint.getDescription() != null ? complaint.getDescription().replace("\"", "&quot;") : "" %>">
                <div class="complaint-info">
                    <div class="complaint-main">
                        <div class="complaint-title"><%= complaint.getTitle() %></div>
                        <div class="complaint-meta">
                            <span class="complaint-user">
                                🔒 Anonymous User
                                <span class="anonymous-badge">👤 Protected</span>
                            </span>
                            <span class="complaint-date">
                                <%=LocalDate.now() %>
                            </span>
                        </div>
                        <div class="admin-remarks" style="display: none;">
                            <%= complaint.getAdminRemark() != null ? complaint.getAdminRemark().replace("\"", "&quot;") : "No remarks added yet." %>
                        </div>
                    </div>
                    <div class="complaint-status">
                        <span class="status-badge <%= statusClass %>">
                            <span><%= statusIcon %></span>
                            <span><%= complaint.getStatus() %></span>
                        </span>
                    </div>
                    <div class="complaint-priority">
                        <span class="priority-badge priority-<%= complaint.getPriority().toLowerCase() %>">
                            <%= complaint.getPriority().equalsIgnoreCase("High") ? "🔴" :
                                    complaint.getPriority().equalsIgnoreCase("Medium") ? "🟡" : "🟢" %>
                            <%= complaint.getPriority() %>
                        </span>
                    </div>
                </div>
                <div class="complaint-actions">
                    <button class="action-btn btn-view" onclick="viewComplaint(<%= complaint.getComplaint_id() %>)">👁️ View</button>
                    <button class="action-btn btn-edit"  onclick="editComplaint(<%= complaint.getComplaint_id() %>)">✏️ Edit</button>
                    <form action="AdminDeleteComplaint" method="post">
                        <input type="hidden" name="complaint_id" value="<%= complaint.getComplaint_id() %>">
                        <button class="action-btn btn-delete" type="submit" onclick="return confirm('Are you sure you want to delete this admin?')">🗑️ Delete</button>
                    </form>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</main>

<!-- View Modal -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">View Complaint Details</h2>
            <span class="close" onclick="closeViewModal()">×</span>
        </div>
        <div class="complaint-details">
            <div class="detail-section">
                <h3 class="detail-title">📋 Complaint Information</h3>
                <div class="detail-grid">
                    <div class="detail-item">
                        <span class="detail-label">Title:</span>
                        <span class="detail-value" id="viewTitle">-</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Date Submitted:</span>
                        <span class="detail-value" id="viewDate">-</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Status:</span>
                        <span class="detail-value" id="viewStatus">-</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Priority:</span>
                        <span class="detail-value" id="viewPriority">-</span>
                    </div>
                </div>
            </div>
            <div class="detail-section">
                <h3 class="detail-title">📝 Description</h3>
                <div class="detail-description" id="viewDescription">No description provided.</div>
            </div>
            <div class="detail-section">
                <h3 class="detail-title">💬 Admin Remarks</h3>
                <div class="detail-remarks" id="viewRemarks">No remarks added yet.</div>
            </div>
        </div>
        <div class="modal-actions">
            <button type="button" class="btn-secondary" onclick="closeViewModal()">Close</button>
            <button type="button" class="btn-primary"  onclick="openEditFromView()">✏️ Edit Complaint</button>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Edit Complaint</h2>
            <span class="close" onclick="closeEditModal()">×</span>
        </div>
        <form id="editForm" action="allComplaint" method="post">
            <input type="hidden" id="complaintId" name="complaint_id">
            <div class="form-group">
                <label class="form-label">📋 Complaint Title:</label>
                <input type="text" class="form-select" id="editTitle" name="title" readonly style="background: rgba(60, 60, 60, 0.5);">
            </div>
            <div class="form-group">
                <label class="form-label">🏷️ Status:</label>
                <select class="form-select" id="complaintStatus" name="status">
                    <option value="PENDING">Pending</option>
                    <option value="IN_PROGRESS">In Progress</option>
                    <option value="RESOLVED">Resolved</option>
                    <option value="REJECTED">Rejected</option>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label">📝 Admin Remarks:</label>
                <textarea class="form-textarea" id="complaintRemarks" name="adminRemark" placeholder="Add your administrative remarks here..."></textarea>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-secondary" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="btn-primary" id="updateBtn">💾 Update Complaint</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/allComplaint.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
<script>
    const updateBtn = document.getElementById('updateBtn');

    if (updateBtn) {
        updateBtn.addEventListener('click', function(event) {
            event.preventDefault();

            Swal.fire({
                icon: 'question',
                title: 'Save Changes?',
                text: 'Are you sure you want to update this complaint?',
                showCancelButton: true,
                confirmButtonText: 'Yes, Update',
                cancelButtonText: 'Cancel',
                confirmButtonColor: '#ff8c00',
                cancelButtonColor: '#888'
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('editForm').submit();
                }
            });
        });
    }
</script>
</body>
</html>