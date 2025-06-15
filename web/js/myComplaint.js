
// Sample data with admin responses
const sampleComplaints = [
    {
        id: 'CMP-001',
        title: 'Poor Service Quality at Branch Office',
        description: 'I visited the downtown branch office last week and experienced extremely poor customer service. The staff was unprofessional and unhelpful.',
        status: 'PENDING',
        dateSubmitted: '2024-12-15',
        priority: 'High',
        adminResponse: null
    },
    {
        id: 'CMP-002',
        title: 'Billing Error in Monthly Statement',
        description: 'There appears to be a calculation error in my December billing statement. I was charged for services I did not use.',
        status: 'IN_PROGRESS',
        dateSubmitted: '2024-12-10',
        priority: 'Medium',
        adminResponse: 'We are currently reviewing your billing statement and will contact you within 2 business days with a resolution.'
    },
    {
        id: 'CMP-003',
        title: 'Website Login Issues',
        description: 'Unable to access my account through the website for the past 3 days. Password reset emails are not being received.',
        status: 'RESOLVED',
        dateSubmitted: '2024-12-05',
        priority: 'Low',
        adminResponse: 'The login issue has been resolved. We have updated our email server configuration and reset your password. Please check your email for the new password and try logging in again.'
    },
    {
        id: 'CMP-004',
        title: 'Damaged Product Delivery',
        description: 'Received a damaged product in my recent order. The packaging was torn and the item inside was broken.',
        status: 'REJECTED',
        dateSubmitted: '2024-11-28',
        priority: 'High',
        adminResponse: 'After reviewing the delivery records and photos, we found that the package was delivered in good condition. The damage may have occurred after delivery. Please contact our customer service for alternative solutions.'
    }
];

let currentComplaints = [...sampleComplaints];

document.addEventListener('DOMContentLoaded', function() {
    const complaintsGrid = document.getElementById('complaintsGrid');
    const emptyState = document.getElementById('emptyState');
    const statusFilter = document.getElementById('statusFilter');

    // Update stats
    function updateStats(complaints) {
        document.getElementById('totalComplaints').textContent = complaints.length;
        document.getElementById('pendingComplaints').textContent =
            complaints.filter(c => c.status === 'PENDING').length;
        document.getElementById('inProgressComplaints').textContent =
            complaints.filter(c => c.status === 'IN_PROGRESS').length;
        document.getElementById('resolvedComplaints').textContent =
            complaints.filter(c => c.status === 'RESOLVED').length;
    }

    // Get status badge HTML
    function getStatusBadge(status) {
        const statusConfig = {
            'PENDING': { class: 'status-pending', icon: '⏳', text: 'Pending' },
            'IN_PROGRESS': { class: 'status-in-progress', icon: '🔄', text: 'In Progress' },
            'RESOLVED': { class: 'status-resolved', icon: '✅', text: 'Resolved' },
            'REJECTED': { class: 'status-rejected', icon: '❌', text: 'Rejected' }
        };

        const config = statusConfig[status] || statusConfig['PENDING'];
        return `<span class="status-badge">
                    <span>${config.icon}</span>
                    <span>${config.text}</span>
                </span>`;
    }

    // Get priority badge HTML
    function getPriorityBadge(priority) {
        const priorityConfig = {
            'High': { icon: '🔴', color: '#dc3545' },
            'Medium': { icon: '🟡', color: '#ffc107' },
            'Low': { icon: '🟢', color: '#28a745' }
        };

        const config = priorityConfig[priority] || priorityConfig['Medium'];
        return `<span style="color: ${config.color};">${config.icon} ${priority}</span>`;
    }

    // Format date
    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        });
    }

    // Render complaints
    function renderComplaints(complaints) {
        if (complaints.length === 0) {
            complaintsGrid.style.display = 'none';
            emptyState.style.display = 'block';
            return;
        }

        complaintsGrid.style.display = 'grid';
        emptyState.style.display = 'none';

        complaintsGrid.innerHTML = complaints.map(complaint => `
                <div class="complaint-card">
                    <div class="complaint-header">
                        <div>
                            <h4 class="complaint-title">${complaint.title}</h4>
                            <div class="complaint-id">ID: ${complaint.id}</div>
                        </div>
                        ${getStatusBadge(complaint.status)}
                    </div>
                    <div class="complaint-meta">
                        <div class="meta-item">
                            <span>📅</span>
                            <span>${formatDate(complaint.dateSubmitted)}</span>
                        </div>
                        <div class="meta-item">
                            <span>⚡</span>
                            <span>${getPriorityBadge(complaint.priority)}</span>
                        </div>
                    </div>
                    <div class="complaint-description">
                        ${complaint.description}
                    </div>
                    <div class="complaint-actions">
                        <button class="action-btn btn-view" onclick="viewComplaint('${complaint.id}')">
                            👁️ View
                        </button>
                        ${complaint.status != 'RESOLVED' ?`
                            <button class="action-btn btn-edit" onclick="editComplaint('${complaint.id}')">
                                ✏️ Edit
                            </button>
                            <button class="action-btn btn-delete" onclick="deleteComplaint('${complaint.id}')">
                                🗑️ Delete
                            </button>
                        ` : ''}
                    </div>
                </div>
            `).join('');
    }

    // Filter complaints
    function filterComplaints() {
        const statusValue = statusFilter.value;
        let filtered = [...currentComplaints];

        if (statusValue) {
            filtered = filtered.filter(complaint => complaint.status === statusValue);
        }

        renderComplaints(filtered);
    }

    // Event listeners
    statusFilter.addEventListener('change', filterComplaints);

    // Initial render
    updateStats(currentComplaints);
    renderComplaints(currentComplaints);
});

// Modal functions
function editComplaint(id) {
    const complaint = currentComplaints.find(c => c.id === id);
    if (!complaint) return;

    document.getElementById('editId').value = complaint.id;
    document.getElementById('editTitle').value = complaint.title;
    document.getElementById('editDescription').value = complaint.description;
    document.getElementById('editModal').style.display = 'block';
}

function closeEditModal() {
    document.getElementById('editModal').style.display = 'none';
}

function saveEdit() {
    const id = document.getElementById('editId').value;
    const title = document.getElementById('editTitle').value.trim();
    const description = document.getElementById('editDescription').value.trim();

    if (!title || !description) {
        alert('Please fill in all required fields.');
        return;
    }

    const complaintIndex = currentComplaints.findIndex(c => c.id === id);
    if (complaintIndex !== -1) {
        currentComplaints[complaintIndex].title = title;
        currentComplaints[complaintIndex].description = description;

        const statusFilter = document.getElementById('statusFilter');
        const statusValue = statusFilter.value;
        let filtered = [...currentComplaints];

        if (statusValue) {
            filtered = filtered.filter(complaint => complaint.status === statusValue);
        }

        renderComplaints(filtered);
        updateStats(currentComplaints);
        closeEditModal();
        showNotification('Complaint updated successfully!', 'success');
    }
}

function viewComplaint(id) {
    const complaint = currentComplaints.find(c => c.id === id);
    if (!complaint) return;

    document.getElementById('viewId').textContent = complaint.id;
    document.getElementById('viewTitle').textContent = complaint.title;
    document.getElementById('viewDescription').textContent = complaint.description;

    const statusConfig = {
        'PENDING': { class: 'status-pending', icon: '⏳', text: 'Pending' },
        'IN_PROGRESS': { class: 'status-in-progress', icon: '🔄', text: 'In Progress' },
        'RESOLVED': { class: 'status-resolved', icon: '✅', text: 'Resolved' },
        'REJECTED': { class: 'status-rejected', icon: '❌', text: 'Rejected' }
    };

    const config = statusConfig[complaint.status] || statusConfig['PENDING'];
    document.getElementById('viewStatus').innerHTML = `
            <span class="status-badge">
                <span>${config.icon}</span>
                <span>${config.text}</span>
            </span>
        `;

    document.getElementById('viewDate').textContent = formatDate(complaint.dateSubmitted);

    const priorityConfig = {
        'High': { icon: '🔴', color: '#dc3545' },
        'Medium': { icon: '🟡', color: '#ffc107' },
        'Low': { icon: '🟢', color: '#28a745' }
    };

    const priorityConf = priorityConfig[complaint.priority] || priorityConfig['Medium'];
    document.getElementById('viewPriority').innerHTML = `
            <span style="color: ${priorityConf.color};">${priorityConf.icon} ${complaint.priority}</span>
        `;

    // Show admin remark if adminResponse exists, regardless of status
    const adminResponseSection = document.getElementById('adminResponseSection');
    const adminResponseText = document.getElementById('viewAdminResponse');
    if (complaint.adminResponse) {
        adminResponseText.textContent = complaint.adminResponse;
        adminResponseSection.style.display = 'block';
    } else {
        adminResponseSection.style.display = 'none';
    }

    document.getElementById('viewModal').style.display = 'block';
}

function closeViewModal() {
    document.getElementById('viewModal').style.display = 'none';
}

function deleteComplaint(id) {
    if (confirm('Are you sure you want to delete this complaint? This action cannot be undone.')) {
        currentComplaints = currentComplaints.filter(c => c.id !== id);

        const statusFilter = document.getElementById('statusFilter');
        const statusValue = statusFilter.value;
        let filtered = [...currentComplaints];

        if (statusValue) {
            filtered = filtered.filter(complaint => complaint.status === statusValue);
        }

        renderComplaints(filtered);
        updateStats(currentComplaints);
        showNotification('Complaint deleted successfully!', 'success');
    }
}

// Utility functions
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
    });
}

function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            z-index: 10000;
            opacity: 0;
            transform: translateX(100%);
            transition: all 0.3s ease;
            max-width: 300px;
            word-wrap: break-word;
        `;

    const colors = {
        'success': '#28a745',
        'error': '#dc3545',
        'warning': '#ffc107',
        'info': '#007bff'
    };

    notification.style.backgroundColor = colors[type] || colors['info'];
    notification.textContent = message;

    document.body.appendChild(notification);

    setTimeout(() => {
        notification.style.opacity = '1';
        notification.style.transform = 'translateX(0)';
    }, 100);

    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// Close modals when clicking outside
window.onclick = function(event) {
    const editModal = document.getElementById('editModal');
    const viewModal = document.getElementById('viewModal');
    if (event.target === editModal) {
        closeEditModal();
    }
    if (event.target === viewModal) {
        closeViewModal();
    }
};

// Keyboard shortcuts
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeEditModal();
        closeViewModal();
    }
});