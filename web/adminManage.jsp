<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Employee" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Management</title>
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
        }

        /* Header Styles */
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

        /* Page Title */
        .page-title {
            text-align: center;
            margin: 30px 0;
        }

        .page-title h1 {
            color: #ff8c00;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 0 15px rgba(255, 140, 0, 0.3);
        }

        .page-title p {
            color: #b0b0b0;
            font-size: 16px;
        }

        /* Dashboard Container */
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Stats Container */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            border: 1px solid rgba(255, 140, 0, 0.2);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(255, 140, 0, 0.2);
        }

        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #ff8c00;
            margin-bottom: 10px;
        }

        .stat-label {
            color: #b0b0b0;
            font-size: 14px;
            font-weight: 500;
        }

        /* Actions Bar */
        .actions-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 30px;
        }

        .add-btn {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 140, 0, 0.5);
        }

        /* Table Styles */
        .table-container {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 140, 0, 0.2);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            padding: 15px 12px;
            font-weight: 600;
            text-align: left;
            font-size: 14px;
        }

        .table td {
            padding: 15px 12px;
            border-bottom: 1px solid #404040;
            font-size: 14px;
        }

        .table tr:hover {
            background: rgba(255, 140, 0, 0.1);
        }

        .profile-pic {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ff8c00;
        }

        .role-badge {
            background: #ff8c00;
            color: #000;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .btn-delete {
            background: #f44336;
            color: white;
        }

        .btn-delete:hover {
            background: #da190b;
            transform: translateY(-1px);
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
        }

        .modal-content {
            background: rgba(30, 30, 30, 0.95);
            margin: 3% auto;
            padding: 0;
            border-radius: 15px;
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 140, 0, 0.2);
            animation: modalSlideIn 0.3s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .modal-header {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            font-size: 20px;
            font-weight: 600;
        }

        .close {
            color: #000;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
            border: none;
            background: none;
            padding: 0;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .close:hover {
            background: rgba(0, 0, 0, 0.1);
            transform: scale(1.1);
        }

        .modal-body {
            padding: 30px;
        }

        /* Form Styles */
        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .form-group {
            flex: 1;
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #e0e0e0;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #404040;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #2a2a2a;
            color: #e0e0e0;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #ff8c00;
            box-shadow: 0 0 0 3px rgba(255, 140, 0, 0.2);
            background: #333333;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .image-upload-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .image-preview {
            width: 120px;
            height: 120px;
            border: 3px dashed #404040;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            background: #2a2a2a;
        }

        .image-preview:hover {
            border-color: #ff8c00;
            background: #333333;
            transform: scale(1.05);
        }

        .image-preview.has-image {
            border-style: solid;
            border-color: #ff8c00;
        }

        .placeholder-icon {
            text-align: center;
            color: #888;
        }

        .placeholder-icon i {
            font-size: 40px;
            color: #ff8c00;
            margin-bottom: 10px;
        }

        .placeholder-icon p {
            font-size: 12px;
            font-weight: 500;
        }

        #previewImg {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .password-group {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #ff8c00;
            font-size: 18px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #404040;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 140, 0, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .hidden {
            display: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .table-container {
                overflow-x: auto;
            }

            .table {
                min-width: 800px;
            }

            .form-row {
                flex-direction: column;
            }

            .dashboard-container {
                padding: 0 15px;
            }
        }
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
        <a href="adminDashboard.jsp" class="back-link">
            ← Back to Dashboard
        </a>
    </div>
</header>

<div class="dashboard-container">
    <div class="page-title">
        <h1><i class="fas fa-users-cog"></i> Admin Management</h1>
        <p>Manage administrator accounts and permissions</p>
    </div>

    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-number" id="totalAdmins">
                <%
                    List<Employee> adminList = (List<Employee>) request.getAttribute("adminList");
                    int totalAdmins = (adminList != null) ? adminList.size() : 0;
                %>
                <%= totalAdmins %>
            </div>
            <div class="stat-label">Total Admins</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="activeAdmins"><%= totalAdmins %></div>
            <div class="stat-label">Active Admins</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="newAdmins">0</div>
            <div class="stat-label">Added Today</div>
        </div>
    </div>

    <div class="actions-bar">
        <button class="add-btn" onclick="openModal()">
            <i class="fas fa-plus"></i>
            Add New Admin
        </button>
    </div>

    <div class="table-container">
        <table class="table">
            <thead>
            <tr>
                <th>Profile</th>
                <th>Full Name</th>
                <th>Username</th>
                <th>Email</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="adminTableBody">
            <%
                if (adminList != null && !adminList.isEmpty()) {
                    for (Employee employee : adminList) {
                        // Null checks for employee fields
                        String profilePic = employee.getProfilePic() != null ? employee.getProfilePic() : "default.jpg";
                        String fullName = employee.getFullName() != null ? employee.getFullName() : "";
                        String username = employee.getUsername() != null ? employee.getUsername() : "";
                        String email = employee.getEmail() != null ? employee.getEmail() : "";
                        String address = employee.getAddress() != null ? employee.getAddress() : "";
            %>
            <tr>
                <td>
                    <img src="Uploads/<%= profilePic %>" alt="Profile" class="profile-pic">
                </td>
                <td><%= fullName %></td>
                <td><%= username %></td>
                <td><%= email %></td>
                <td><%= address %></td>
                <td class="action-buttons">
                    <form action="deleteAdmin" method="post" style="display: inline-block;">
                        <input type="hidden" name="username" value="<%= username %>">
                        <button type="submit" class="btn btn-delete"
                                onclick="return confirm('Are you sure you want to delete this admin?')">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6" style="text-align: center; color: #b0b0b0;">No admins found</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal for Add Admin -->
<div id="adminModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 id="modalTitle">Add New Admin</h2>
            <button class="close" onclick="closeModal()">×</button>
        </div>
        <div class="modal-body">
            <form id="adminForm" action="adminManage" method="post" enctype="multipart/form-data">
                <div class="image-upload-container">
                    <div class="image-preview" id="imagePreview" onclick="document.getElementById('profilePic').click()">
                        <div class="placeholder-icon" id="placeholderIcon">
                            <i class="fas fa-user-plus"></i>
                            <p>Upload Photo</p>
                        </div>
                        <img id="previewImg" src="" alt="Profile Preview" style="display: none;">
                    </div>
                    <input type="file" id="profilePic" accept="image/*" style="display: none;" name="profilePic"
                           onchange="previewImage(event)">
                </div>

                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>

                <div class="form-group">
                    <label for="address">Address *</label>
                    <textarea id="address" name="address" required placeholder="Enter complete address"></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="username">Username *</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Password *</label>
                        <div class="password-group">
                            <input type="password" id="password" name="password" required>
                            <span class="password-toggle" onclick="togglePassword('password')">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password *</label>
                        <div class="password-group">
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                            <span class="password-toggle" onclick="togglePassword('confirmPassword')">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="role">Role *</label>
                    <input type="text" id="role" name="role" value="Admin" readonly>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn-secondary" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn-primary" id="submitBtn">Add Admin</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
<script src="js/adminManage.js"></script>
</body>
</html>