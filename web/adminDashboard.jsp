<%--
  Created by IntelliJ IDEA.
  User: Nethushi
  Date: 6/14/2025
  Time: 7:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
            max-width: 1200px;
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

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .welcome-text {
            font-size: 18px;
            color: #e0e0e0;
            font-weight: 600;
        }

        .user-name {
            color: #ff8c00;
            font-weight: 700;
        }

        .logout-btn {
            background: linear-gradient(135deg, #ff4757 0%, #ff0000 100%);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 71, 87, 0.4);
        }

        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }

        .dashboard-card {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(255, 140, 0, 0.2);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
        }

        .dashboard-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            border-color: rgba(255, 140, 0, 0.4);
        }

        .card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 20px;
            box-shadow: 0 6px 20px rgba(255, 140, 0, 0.3);
        }

        .card-title {
            font-size: 22px;
            font-weight: 700;
            color: #ff8c00;
            margin-bottom: 10px;
        }

        .card-description {
            color: #b0b0b0;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .card-action {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
        }

        .card-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 140, 0, 0.5);
            background: linear-gradient(135deg, #ffa500 0%, #ff7700 100%);
        }

        /* Welcome Section */
        .welcome-section {
            text-align: center;
            margin-bottom: 20px;
        }

        .welcome-title {
            font-size: 36px;
            font-weight: 700;
            color: #ff8c00;
            margin-bottom: 10px;
            text-shadow: 0 0 20px rgba(255, 140, 0, 0.4);
        }

        .welcome-subtitle {
            font-size: 18px;
            color: #b0b0b0;
            font-weight: 400;
        }

        /* Stats Section */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
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
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #ff8c00;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #b0b0b0;
            font-size: 14px;
            font-weight: 500;
        }

        /* Quick Actions */
        .quick-actions {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(255, 140, 0, 0.2);
            margin-top: 30px;
        }

        .quick-actions h3 {
            color: #ff8c00;
            font-size: 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .action-button {
            background: rgba(255, 140, 0, 0.1);
            border: 2px solid rgba(255, 140, 0, 0.3);
            color: #ff8c00;
            padding: 12px 20px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-button:hover {
            background: rgba(255, 140, 0, 0.2);
            border-color: #ff8c00;
            transform: translateY(-2px);
        }

        /* Admin specific styles */
        .admin-badge {
            background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%);
            color: #000;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            margin-left: 10px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }

            .user-info {
                flex-direction: column;
                gap: 15px;
            }

            .welcome-title {
                font-size: 28px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .stats-section {
                grid-template-columns: repeat(2, 1fr);
            }

            .action-buttons {
                justify-content: center;
            }
        }

        /* Animations */
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

        .dashboard-card {
            animation: fadeInUp 0.6s ease-out;
        }

        .dashboard-card:nth-child(1) { animation-delay: 0.1s; }
        .dashboard-card:nth-child(2) { animation-delay: 0.2s; }
        .dashboard-card:nth-child(3) { animation-delay: 0.3s; }
        .dashboard-card:nth-child(4) { animation-delay: 0.4s; }

        /* Scrollbar styling */
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
            <div class="logo-icon">A</div>
            <div class="logo-text">Admin Portal</div>
        </div>
        <div class="user-info">
            <div class="welcome-text">
                Welcome, <span class="user-name">Administrator</span>
                <span class="admin-badge">ADMIN</span>
            </div>
            <a href="index.jsp" class="logout-btn">
                🚪 Logout
            </a>
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="main-content">
    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1 class="welcome-title">Admin Dashboard</h1>
        <p class="welcome-subtitle">Manage complaints, users, and system administration</p>
    </div>

    <!-- Stats Section -->
    <div class="stats-section">
        <div class="stat-card">
            <div class="stat-number">0</div>
            <div class="stat-label">Total Complaints</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">0</div>
            <div class="stat-label">Pending Reviews</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">0</div>
            <div class="stat-label">Resolved Today</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">0</div>
            <div class="stat-label">Active Users</div>
        </div>
    </div>

    <!-- Main Actions -->
    <div class="dashboard-grid">
        <!-- View All Complaints Card -->
        <div class="dashboard-card">
            <div class="card-icon">📋</div>
            <h3 class="card-title">All Complaints</h3>
            <p class="card-description">
                View, manage, and respond to all complaints submitted by employees. Track status and assign priority levels.
            </p>
            <a href="allComplaint.jsp" class="card-action">
                👁️ View All Complaints
            </a>
        </div>

        <!-- Manage Admins Card -->
        <div class="dashboard-card">
            <div class="card-icon">👥</div>
            <h3 class="card-title">Manage Administrators</h3>
            <p class="card-description">
                Add, remove, or modify administrator accounts. Control access levels and permissions for admin users.
            </p>
            <a href="adminManage.jsp" class="card-action">
                ⚙️ Manage Admins
            </a>
        </div>

    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <h3>⚡ Quick Admin Actions</h3>
        <div class="action-buttons">
            <a href="allComplaint.jsp" class="action-button">
                📝 Recent Complaints
            </a>
            <a href="#" class="action-button">
                🚨 Priority Issues
            </a>
            <a href="#" class="action-button">
                🔧 System Settings
            </a>
            <a href="#" class="action-button">
                👥 User Activity
            </a>
            <a href="#" class="action-button">
                📞 Support Center
            </a>
        </div>
    </div>
</main>

<script src="js/adminDashboard.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>