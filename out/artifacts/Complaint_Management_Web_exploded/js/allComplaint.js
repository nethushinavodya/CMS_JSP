// Sample complaint data - replace with actual data from server
const complaintsData = [
    {
        id: 1,
        title: "Workplace Harassment Issue",
        date: "2025-06-10",
        status: "PENDING",
        priority: "high",
        description: "I am experiencing inappropriate behavior from a colleague that is making me uncomfortable in the workplace. This includes unwanted comments and gestures that are affecting my ability to work effectively. I have tried to address this directly but the behavior continues.",
        remarks: "Initial complaint received, investigation pending. HR department has been notified."
    },
    {
        id: 2,
        title: "Office Equipment Malfunction",
        date: "2025-06-09",
        status: "IN_PROGRESS",
        priority: "medium",
        description: "The computer workstation in my cubicle has been experiencing frequent crashes and slow performance. This is significantly impacting my productivity and ability to meet deadlines. The issue has persisted for over a week despite basic troubleshooting attempts.",
        remarks: "Equipment replacement ordered, expected delivery in 3 days. IT department assigned to resolve."
    },
    {
        id: 3,
        title: "Break Room Cleanliness",
        date: "2025-06-08",
        status: "RESOLVED",
        priority: "low",
        description: "The break room has been consistently dirty with dishes left unwashed, spills not cleaned up, and the refrigerator containing expired items. This creates an unpleasant environment and potential health concerns.",
        remarks: "Cleaning schedule updated, additional cleaning staff assigned. Issue resolved."
    },
    {
        id: 4,
        title: "Unsafe Working Conditions",
        date: "2025-06-12",
        status: "PENDING",
        priority: "high",
        description: "There are exposed electrical wires in the storage area that pose a serious safety risk. Additionally, the emergency exit is partially blocked by equipment. These conditions could lead to accidents or impede evacuation in case of emergency.",
        remarks: ""
    }
];

// Initialize the page
document.addEventListener('DOMContentLoaded', function() {
    setupEventListeners();
    updateStats();
});

function setupEventListeners() {
    // Search functionality
    const searchInput = document.querySelector('.search-input');
    searchInput.addEventListener('input', filterComplaints);

    // Filter functionality
    const statusFilter = document.getElementById('statusFilter');
    const priorityFilter = document.getElementById('priorityFilter');
    statusFilter.addEventListener('change', filterComplaints);
    priorityFilter.addEventListener('change', filterComplaints);

    // Edit form submission
    const editForm = document.getElementById('editForm');
    editForm.addEventListener('submit', handleEditSubmit);

    // Modal close on outside click
    const viewModal = document.getElementById('viewModal');
    const editModal = document.getElementById('editModal');

    window.addEventListener('click', function(event) {
        if (event.target === viewModal) {
            closeViewModal();
        }
        if (event.target === editModal) {
            closeEditModal();
        }
    });
}

// View complaint function
function viewComplaint(id) {
    const complaint = complaintsData.find(c => c.id === id);
    if (!complaint) return;

    // Populate view modal
    document.getElementById('viewTitle').textContent = complaint.title;
    document.getElementById('viewDate').textContent = complaint.date;
    document.getElementById('viewStatus').textContent = complaint.status.replace('_', ' ');
    document.getElementById('viewPriority').textContent = complaint.priority.charAt(0).toUpperCase() + complaint.priority.slice(1);
    document.getElementById('viewDescription').textContent = complaint.description;
    document.getElementById('viewRemarks').textContent = complaint.remarks || 'No remarks added yet.';

    document.getElementById('viewModal').style.display = 'block';
}

// Edit complaint function
function editComplaint(id) {
    const complaint = complaintsData.find(c => c.id === id);
    if (!complaint) return;

    // Populate edit modal
    document.getElementById('complaintId').value = complaint.id;
    document.getElementById('editTitle').value = complaint.title;
    document.getElementById('complaintStatus').value = complaint.status;
    document.getElementById('complaintRemarks').value = complaint.remarks;

    document.getElementById('editModal').style.display = 'block';
}

// Handle edit form submission
function handleEditSubmit(e) {
    e.preventDefault();

    const formData = new FormData(e.target);
    const complaintId = formData.get('complaint_id');

    // Update local data
    const complaint = complaintsData.find(c => c.id == complaintId);
    if (complaint) {
        complaint.status = formData.get('status');
        complaint.remarks = formData.get('remarks');

        // Update the UI for the complaint card
        const card = document.querySelector(`.complaint-card[data-id="${complaintId}"]`);
        if (card) {
            card.dataset.status = complaint.status;
            const statusBadge = card.querySelector('.status-badge');
            statusBadge.textContent = complaint.status.replace('_', ' ');
            statusBadge.className = `status-badge status-${complaint.status.toLowerCase().replace('_', '-')}`;
        }
    }

    closeEditModal();
    showNotification('Complaint updated successfully', 'success');
    updateStats();
    filterComplaints(); // Reapply filters to ensure UI consistency
}

// Open edit modal from view modal
function openEditFromView() {
    const viewTitle = document.getElementById('viewTitle').textContent;
    const complaint = complaintsData.find(c => c.title === viewTitle);
    if (complaint) {
        closeViewModal();
        editComplaint(complaint.id);
    }
}

// Delete complaint function
function deleteComplaint(id) {
    if (confirm('Are you sure you want to delete this complaint? This action cannot be undone.')) {
        // For demo purposes, remove from data and UI
        const index = complaintsData.findIndex(c => c.id == id);
        if (index !== -1) {
            complaintsData.splice(index, 1);
        }

        const card = document.querySelector(`.complaint-card[data-id="${id}"]`);
        if (card) {
            card.style.transition = 'all 0.3s ease';
            card.style.transform = 'translateX(-100%)';
            card.style.opacity = '0';
            setTimeout(() => card.remove(), 300);
        }

        updateStats();
        showNotification('Complaint deleted successfully', 'success');
    }
}

// Close modal functions
function closeViewModal() {
    document.getElementById('viewModal').style.display = 'none';
}

function closeEditModal() {
    document.getElementById('editModal').style.display = 'none';
}

// Handle edit form submission
function handleEditSubmit(e) {
    e.preventDefault();

    const formData = new FormData(e.target);
    const complaintId = formData.get('complaint_id');

    // Update local data
    const complaint = complaintsData.find(c => c.id == complaintId);
    if (complaint) {
        complaint.status = formData.get('status');
        complaint.priority = formData.get('priority');
        complaint.remarks = formData.get('remarks');

        // Update the UI for the complaint card
        const card = document.querySelector(`.complaint-card[data-id="${complaintId}"]`);
        if (card) {
            card.dataset.status = complaint.status;
            card.dataset.priority = complaint.priority;
            const statusBadge = card.querySelector('.status-badge');
            const priorityBadge = card.querySelector('.priority-badge');
            statusBadge.textContent = complaint.status.replace('_', ' ');
            statusBadge.className = `status-badge status-${complaint.status.toLowerCase().replace('_', '-')}`;
            priorityBadge.textContent = complaint.priority.charAt(0).toUpperCase() + complaint.priority.slice(1);
            priorityBadge.className = `priority-badge priority-${complaint.priority}`;
        }
    }

    closeEditModal();
    showNotification('Complaint updated successfully', 'success');
    updateStats();
    filterComplaints(); // Reapply filters to ensure UI consistency
}

function filterComplaints() {
    const searchTerm = document.querySelector('.search-input').value.toLowerCase();
    const statusFilter = document.getElementById('statusFilter').value;
    const priorityFilter = document.getElementById('priorityFilter').value;

    const cards = document.querySelectorAll('.complaint-card');

    cards.forEach(card => {
        const title = card.querySelector('.complaint-title').textContent.toLowerCase();
        const user = card.querySelector('.complaint-user').textContent.toLowerCase();
        const status = card.dataset.status;
        const priority = card.dataset.priority;

        const matchesSearch = title.includes(searchTerm) || user.includes(searchTerm);
        const matchesStatus = !statusFilter || status === statusFilter;
        const matchesPriority = !priorityFilter || priority === priorityFilter;

        if (matchesSearch && matchesStatus && matchesPriority) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

function updateStats() {
    const pending = complaintsData.filter(c => c.status === 'PENDING').length;
    const progress = complaintsData.filter(c => c.status === 'IN_PROGRESS').length;
    const resolved = complaintsData.filter(c => c.status === 'RESOLVED').length;
    const total = complaintsData.length;

    document.getElementById('totalComplaints').textContent = total;
    document.getElementById('pendingCount').textContent = pending;
    document.getElementById('progressCount').textContent = progress;
    document.getElementById('resolvedCount').textContent = resolved;
}

// Show notification function
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            background: ${type == 'success' ? 'linear-gradient(135deg, #4CAF50 0%, #45a049 100%)' : 'linear-gradient(135deg, #ff8c00 0%, #ff6600 100%)'};
            color: white;
            border-radius: 8px;
            font-weight: 600;
            z-index: 2000;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            transform: translateX(100%);
            transition: transform 0.3s ease;
        `;
    notification.textContent = message;

    document.body.appendChild(notification);

    setTimeout(() => notification.style.transform = 'translateX(0)', 100);

    setTimeout(() => {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}