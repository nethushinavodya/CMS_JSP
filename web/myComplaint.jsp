<%@ page import="org.example.entity.Complaints" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.dto.ComplaintsDTO" %><%--
  Created by IntelliJ IDEA.
  User: Nethushi
  Date: 6/13/2025
  Time: 3:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Complaints</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
  <style>
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
      padding: 20px;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      background: rgba(30, 30, 30, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      border: 1px solid rgba(255, 140, 0, 0.2);
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
      overflow: hidden;
      animation: fadeInUp 0.6s ease-out;
    }

    .header {
      background: rgba(30, 30, 30, 0.95);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(255, 140, 0, 0.2);
      padding: 20px 0;
      position: sticky;
      top: 0;
      z-index: 100;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
      margin: -20px -20px 30px -20px;
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

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 8px;
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

    .content {
      padding: 40px;
    }

    .actions-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      flex-wrap: wrap;
      gap: 15px;
    }

    .add-btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
      color: #000;
      text-decoration: none;
      font-weight: 600;
      padding: 12px 20px;
      border-radius: 10px;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
      border: none;
      cursor: pointer;
    }

    .add-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(255, 140, 0, 0.5);
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .stat-card {
      background: rgba(50, 50, 50, 0.8);
      border: 1px solid rgba(255, 140, 0, 0.2);
      border-radius: 12px;
      padding: 20px;
      text-align: center;
      transition: all 0.3s ease;
    }

    .stat-card:hover {
      transform: translateY(-5px);
      border-color: rgba(255, 140, 0, 0.4);
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    }

    .stat-number {
      font-size: 24px;
      font-weight: 700;
      color: #ff8c00;
      margin-bottom: 5px;
    }

    .stat-label {
      font-size: 14px;
      color: #b0b0b0;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .complaints-container {
      background: rgba(18, 18, 18, 0.8);
      border-radius: 15px;
      padding: 30px;
      border: 1px solid rgba(255, 140, 0, 0.1);
    }

    .table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .table-title {
      font-size: 20px;
      font-weight: 600;
      color: #ff8c00;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .filter-controls {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .filter-select {
      background: rgba(60, 60, 60, 0.8);
      border: 1px solid rgba(255, 140, 0, 0.3);
      border-radius: 6px;
      color: #e0e0e0;
      padding: 8px 12px;
      font-size: 14px;
    }

    .complaints-grid {
      display: grid;
      gap: 20px;
      margin-top: 20px;
    }

    .complaint-card {
      background: rgba(60, 60, 60, 0.8);
      border: 1px solid rgba(255, 140, 0, 0.2);
      border-radius: 12px;
      padding: 25px;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .complaint-card:hover {
      transform: translateY(-3px);
      border-color: rgba(255, 140, 0, 0.4);
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
    }

    .complaint-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 4px;
      height: 100%;
      background: #ff8c00;
      transition: width 0.3s ease;
    }

    .complaint-card:hover::before {
      width: 8px;
    }

    .complaint-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 15px;
      gap: 15px;
    }

    .complaint-title {
      font-size: 18px;
      font-weight: 600;
      color: #e0e0e0;
      margin-bottom: 5px;
      flex: 1;
    }

    .complaint-id {
      font-size: 12px;
      color: #888;
      font-family: monospace;
    }

    .status-badge {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      display: flex;
      align-items: center;
      gap: 5px;
      white-space: nowrap;
    }

    .status-pending {
      background: rgba(255, 193, 7, 0.2);
      color: #ffc107;
      border: 1px solid rgba(255, 193, 7, 0.3);
    }

    .status-in-progress {
      background: rgba(0, 123, 255, 0.2);
      color: #007bff;
      border: 1px solid rgba(0, 123, 255, 0.3);
    }

    .status-resolved {
      background: rgba(40, 167, 69, 0.2);
      color: #28a745;
      border: 1px solid rgba(40, 167, 69, 0.3);
    }

    .status-rejected {
      background: rgba(220, 53, 69, 0.2);
      color: #dc3545;
      border: 1px solid rgba(220, 53, 69, 0.3);
    }

    .complaint-meta {
      display: flex;
      gap: 20px;
      margin-bottom: 15px;
      color: #b0b0b0;
      font-size: 14px;
    }

    .meta-item {
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .complaint-description {
      color: #c0c0c0;
      line-height: 1.5;
      margin-bottom: 20px;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .complaint-actions {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
    }

    .action-btn {
      padding: 8px 16px;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      text-decoration: none;
      display: inline-flex;
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

    .empty-state {
      text-align: center;
      padding: 60px 20px;
      color: #888;
    }

    .empty-icon {
      font-size: 64px;
      margin-bottom: 20px;
      opacity: 0.5;
    }

    .empty-title {
      font-size: 20px;
      font-weight: 600;
      margin-bottom: 10px;
    }

    .empty-text {
      font-size: 16px;
      line-height: 1.5;
      margin-bottom: 30px;
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
      background-color: rgba(0, 0, 0, 0.7);
      backdrop-filter: blur(5px);
    }

    .modal-content {
      background: rgba(30, 30, 30, 0.98);
      margin: 5% auto;
      padding: 0;
      border: 1px solid rgba(255, 140, 0, 0.3);
      border-radius: 15px;
      width: 90%;
      max-width: 600px;
      max-height: 90vh;
      overflow-y: auto;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
      animation: modalSlideIn 0.3s ease-out;
    }

    .modal-header {
      background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
      color: #000;
      padding: 20px 25px;
      border-radius: 15px 15px 0 0;
      font-weight: 600;
      font-size: 18px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .modal-body {
      padding: 25px;
    }

    .modal-footer {
      padding: 0 25px 25px 25px;
      display: flex;
      gap: 10px;
      justify-content: flex-end;
    }

    .close {
      color: #000;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
      transition: transform 0.2s ease;
    }

    .close:hover {
      transform: scale(1.1);
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-label {
      display: block;
      margin-bottom: 8px;
      color: #ff8c00;
      font-weight: 600;
      font-size: 14px;
    }

    .form-input, .form-textarea, .form-select {
      width: 100%;
      padding: 12px 15px;
      background: rgba(60, 60, 60, 0.8);
      border: 1px solid rgba(255, 140, 0, 0.3);
      border-radius: 8px;
      color: #e0e0e0;
      font-size: 14px;
      font-family: inherit;
      transition: all 0.3s ease;
    }

    .form-input:focus, .form-textarea:focus, .form-select:focus {
      outline: none;
      border-color: #ff8c00;
      box-shadow: 0 0 0 2px rgba(255, 140, 0, 0.2);
    }

    .form-textarea {
      resize: vertical;
      min-height: 100px;
    }

    .btn-primary {
      background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
      color: #000;
      border: none;
      padding: 12px 24px;
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
      background: rgba(108, 117, 125, 0.3);
      color: #e0e0e0;
      border: 1px solid rgba(108, 117, 125, 0.5);
      padding: 12px 24px;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-secondary:hover {
      background: rgba(108, 117, 125, 0.5);
      transform: translateY(-1px);
    }

    .view-detail {
      margin-bottom: 15px;
    }

    .view-label {
      font-weight: 600;
      color: #ff8c00;
      margin-bottom: 5px;
      display: block;
    }

    .view-value {
      color: #e0e0e0;
      line-height: 1.5;
      background: rgba(60, 60, 60, 0.5);
      padding: 10px 12px;
      border-radius: 6px;
      border-left: 3px solid #ff8c00;
      word-wrap: break-word;
    }

    .admin-response {
      background: rgba(40, 167, 69, 0.1);
      border: 1px solid rgba(40, 167, 69, 0.3);
      border-radius: 8px;
      padding: 15px;
      margin-top: 15px;
    }

    .admin-response-label {
      color: #28a745;
      font-weight: 600;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .admin-response-text {
      color: #e0e0e0;
      line-height: 1.5;
      word-wrap: break-word;
      white-space: pre-wrap;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
      body {
        padding: 10px;
      }

      .container {
        border-radius: 15px;
      }

      .content {
        padding: 25px 20px;
      }

      .actions-bar {
        flex-direction: column;
        align-items: stretch;
      }

      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
      }

      .complaints-container {
        padding: 20px;
      }

      .complaint-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
      }

      .complaint-actions {
        justify-content: flex-start;
      }

      .filter-controls {
        width: 100%;
        justify-content: space-between;
      }

      .modal-content {
        margin: 10% auto;
        width: 95%;
      }

      .modal-footer {
        flex-direction: column;
      }
    }

    @media (max-width: 480px) {
      .stats-grid {
        grid-template-columns: 1fr;
      }

      .complaint-meta {
        flex-direction: column;
        gap: 8px;
      }

      .complaint-actions {
        flex-direction: column;
      }

      .action-btn {
        text-align: center;
        justify-content: center;
      }
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes modalSlideIn {
      from {
        opacity: 0;
        transform: translateY(-50px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* Custom scrollbar */
    ::-webkit-scrollbar {
      width: 8px;
    }

    ::-webkit-scrollbar-track {
      background: #2a2a2a;
    }

    ::-webkit-scrollbar-thumb {
      background: #ff8c00;
      border-radius: 4px;
    }

    ::-webkit-scrollbar-thumb:hover {
      background: #ffa500;
    }
  </style>
</head>
<body>
<!-- Header -->
<header class="header">
  <div class="header-content">
    <div class="logo">
      <div class="logo-icon">E</div>
      <div class="logo-text">Employee Portal</div>
    </div>
    <a href="employeeDashboard.jsp" class="back-link">
      ← Back to Dashboard
    </a>
  </div>
</header>

    <!-- Actions Bar -->
    <div class="actions-bar">
      <button class="add-btn" onclick="window.location.href='submitComplaint.jsp'">
        ➕ New Complaint
      </button>
    </div>

    <!-- Stats Grid -->
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-number" id="totalComplaints">0</div>
        <div class="stat-label">Total Complaints</div>
      </div>
      <div class="stat-card">
        <div class="stat-number" id="pendingComplaints">0</div>
        <div class="stat-label">Pending</div>
      </div>
      <div class="stat-card">
        <div class="stat-number" id="inProgressComplaints">0</div>
        <div class="stat-label">In Progress</div>
      </div>
      <div class="stat-card">
        <div class="stat-number" id="resolvedComplaints">0</div>
        <div class="stat-label">Resolved</div>
      </div>
    </div>

    <!-- Complaints Container -->
    <div class="complaints-container">
      <div class="table-header">
        <h3 class="table-title">
          📝 Your Complaints
        </h3>
        <div class="filter-controls">
          <select class="filter-select" id="statusFilter">
            <option value="">All Status</option>
            <option value="PENDING">Pending</option>
            <option value="IN_PROGRESS">In Progress</option>
            <option value="RESOLVED">Resolved</option>
            <option value="REJECTED">Rejected</option>
          </select>
        </div>
      </div>

      <!-- Complaints Grid -->
      <div class="complaints-grid" id="complaintsGrid">
        <%
          List<ComplaintsDTO> complaints = (List<ComplaintsDTO>) request.getAttribute("complaints");
          System.out.println(complaints.size());
          if (complaints.size() == 0) {
            System.out.println("empty");
        %>
        <h1>No Complaints Found</h1>
        <%
        }else{
          for (ComplaintsDTO complaint : complaints) {
            System.out.println("kkkkkkkkkkkkkk");
        %>
        <!-- Sample Card 1 - Pending -->
        <div class="complaint-card">
          <div class="complaint-header">
            <div>
              <h4 class="complaint-title"><%=complaint.getTitle()%></h4>
              <div class="complaint-id"><%=complaint.getComplaint_id()%></div>
            </div>
            <span class="status-badge status-pending">
                    <span>⏳</span>
                    <span><%=complaint.getStatus()%></span>
                </span>
          </div>
          <div class="complaint-meta">
            <div class="meta-item">
              <span>📅</span>
              <span>Dec 15, 2024</span>
            </div>
            <div class="meta-item">
              <span>⚡</span>
              <span class="priority-high">🔴 <%=complaint.getPriority()%></span>
            </div>
          </div>
          <div class="complaint-description">
            <%=complaint.getDescription()%>
          </div>
          <div class="complaint-actions">
            <button class="action-btn btn-view" onclick="viewComplaint(<%=complaint.getComplaint_id()%>)">
              👁️ View
            </button>
            <%
              // Only show edit and delete buttons if status is not "Resolved"
              if (!"Resolved".equals(complaint.getStatus())) {

                System.out.println(complaint.getStatus() + " " + "Resolved");
            %>
            <button class="action-btn btn-edit" onclick="editComplaint(<%=complaint.getComplaint_id()%>)">
              ✏️ Edit
            </button>
            <form action="deleteComplaint" method="post">
              <input type="hidden" name="complaint_id" value="<%=complaint.getComplaint_id()%>">
              <button type="submit" class="action-btn btn-delete" name="deleteComplaint">
                🗑️ Delete
              </button>
            </form>
            <%
              }
            %>
          </div>
        </div>
        <%
            }
          }
        %>
      </div>

      <!-- Empty State -->
      <div class="empty-state" id="emptyState" style="display: none;">
        <div class="empty-icon">📭</div>
        <h3 class="empty-title">No Complaints Found</h3>
        <p class="empty-text">You haven't submitted any complaints yet.<br>Click "New Complaint" to get started.</p>
        <button class="add-btn" onclick="window.location.href='submitComplaint.jsp'">
          ➕ Submit Your First Complaint
        </button>
      </div>
    </div>



<!-- Edit Modal -->
<div id="editModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <span>✏️ Edit Complaint</span>
      <span class="close" onclick="closeEditModal()">×</span>
    </div>
    <div class="modal-body">
      <form id="editForm" action="ViewAndEditComplaint" method="post">
        <div class="form-group">
          <label class="form-label">Complaint ID</label>
          <input type="text" id="editId" class="form-input" name="complaint_id" readonly>
        </div>
        <div class="form-group">
          <label class="form-label">Title *</label>
          <input name="title" type="text" id="editTitle" class="form-input" required>
        </div>
        <div class="form-group">
          <label class="form-label">Description *</label>
          <textarea id="editDescription" name="description" class="form-textarea" rows="5" required></textarea>
        </div>
        <div class="form-group">
          <label class="form-label">Priority *</label>
          <select id="editPriority" name="priority" class="form-select" required>
            <option value="High">High</option>
            <option value="Medium">Medium</option>
            <option value="Low">Low</option>
          </select>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn-secondary" onclick="closeEditModal()">Cancel</button>
          <button type="submit" class="btn-primary" >Save Changes</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- View Modal -->
<div id="viewModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <span>👁️ View Complaint Details</span>
      <span class="close" onclick="closeViewModal()">×</span>
    </div>
    <div class="modal-body">

      <div class="view-detail">
        <span class="view-label">Complaint ID:</span>
        <div class="view-value" id="viewId"></div>
      </div>

      <div class="view-detail">
        <span class="view-label">Title:</span>
        <div class="view-value" id="viewTitle"></div>
      </div>
      <div class="view-detail">
        <span class="view-label">Description:</span>
        <div class="view-value" id="viewDescription"></div>
      </div>
      <div class="view-detail">
        <span class="view-label">Status:</span>
        <div class="view-value" id="viewStatus"></div>
      </div>
      <div class="view-detail">
        <span class="view-label">Date Submitted:</span>
        <div class="view-value" id="viewDate"></div>
      </div>
      <div class="view-detail">
        <span class="view-label">Priority:</span>
        <div class="view-value" id="viewPriority"></div>
      </div>
      <div id="adminResponseSection" style="display: none;">
        <div class="admin-response">
          <div class="admin-response-label">
            <span>📝</span>
            <span>Admin Remark:</span>
          </div>
          <div class="admin-response-text" id="viewAdminResponse"></div>
        </div>
      </div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn-secondary" onclick="closeViewModal()">Close</button>
    </div>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/myComplaint.js"></script>
</body>
</html>