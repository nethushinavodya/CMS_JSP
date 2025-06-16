
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
function viewComplaint(id) {
    const card = document.querySelector(`.complaint-card[data-id='${id}']`);
    if (!card) return;

    const title = card.querySelector('.complaint-title').textContent;
    const status = card.getAttribute('data-status');
    const priority = card.getAttribute('data-priority');
    const description = card.getAttribute('data-description');
    const date = card.querySelector('.complaint-date').textContent;
    const remarks = card.querySelector('.admin-remarks')?.textContent || "No remarks added yet.";

    // Set values into the view modal
    document.getElementById('viewTitle').textContent = title;
    document.getElementById('viewStatus').textContent = status.charAt(0) + status.slice(1).toLowerCase();
    document.getElementById('viewPriority').textContent = priority.charAt(0).toUpperCase() + priority.slice(1);
    document.getElementById('viewDescription').textContent = description;
    document.getElementById('viewRemarks').textContent = remarks;
    document.getElementById('viewDate').textContent = date;

    // Store the current complaint id to be used when clicking "Edit from View"
    document.getElementById('editForm').setAttribute('data-edit-id', id);

    // Show the modal
    document.getElementById('viewModal').style.display = 'block';
}

function closeViewModal() {
    document.getElementById('viewModal').style.display = 'none';
}

function openEditFromView() {
    const id = document.getElementById('editForm').getAttribute('data-edit-id');
    if (id) {
        editComplaint(id);
        closeViewModal();
    }
}
// Edit complaint function
function editComplaint(id) {
    const card = document.querySelector(`.complaint-card[data-id='${id}']`);
    if (!card) return;

    const title = card.querySelector('.complaint-title').textContent;
    const status = card.getAttribute('data-status');
    const priority = card.getAttribute('data-priority');
    const description = card.getAttribute('data-description');
    const remarks = card.querySelector('.admin-remarks')?.textContent || "";

    // Fill form fields
    document.getElementById('complaintId').value = id;
    document.getElementById('editTitle').value = title;
    document.getElementById('complaintStatus').value = status;
    document.getElementById('complaintRemarks').value = remarks;

    // Show the modal
    document.getElementById('editModal').style.display = 'block';
}

function closeEditModal() {
    document.getElementById('editModal').style.display = 'none';
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