// Get modal elements
const editModal = document.getElementById('editModal');
const viewModal = document.getElementById('viewModal');
const emptyState = document.getElementById('emptyState');
const complaintsGrid = document.getElementById('complaintsGrid');
const statusFilter = document.getElementById('statusFilter');

// Function to open edit modal
function editComplaint(complaintId) {
    const complaintsGrid = document.getElementById('complaintsGrid');

    const card = Array.from(complaintsGrid.getElementsByClassName('complaint-card')).find(card =>
        card.querySelector('.complaint-id').textContent.trim() == complaintId
    );

    if (card) {
        const title = card.querySelector('.complaint-title').textContent.trim();
        const description = card.querySelector('.complaint-description').textContent.trim();
        const priorityRaw = card.getAttribute('data-priority')?.trim().toLowerCase();

        console.log("Raw priority from data attribute:", priorityRaw);

        let priority = 'High'; // default
        if (priorityRaw === 'medium') priority = 'Medium';
        else if (priorityRaw === 'low') priority = 'Low';

        document.getElementById('editId').value = complaintId;
        document.getElementById('editTitle').value = title;
        document.getElementById('editDescription').value = description;
        document.getElementById('editPriority').value = priority;

        document.getElementById('editModal').style.display = 'block';
    } else {
        alert('Complaint not found.');
    }
}

// Function to close edit modal
function closeEditModal() {
    editModal.style.display = 'none';
    document.getElementById('editForm').reset();
}

// Function to save edited complaint
function saveEdit() {
    const id = document.getElementById('editId').value;
    const title = document.getElementById('editTitle').value;
    const description = document.getElementById('editDescription').value;

    if (!title || !description) {
        alert('Please fill in all required fields.');
        return;
    }

    // Update the complaint card in the DOM
    const card = Array.from(complaintsGrid.children).find(card =>
        card.querySelector('.complaint-id').textContent == id
    );

    if (card) {
        card.querySelector('.complaint-title').textContent = title;
        card.querySelector('.complaint-description').textContent = description;
        alert('Complaint updated successfully.');
        closeEditModal();
    } else {
        alert('Error updating complaint.');
    }
}

// Function to open view modal
function viewComplaint(complaintId) {
    // Find the complaint card by ID
    const card = Array.from(complaintsGrid.children).find(card =>
        card.querySelector('.complaint-id').textContent == complaintId
    );

    if (card) {
        // Extract data from the card
        const title = card.querySelector('.complaint-title').textContent;
        const description = card.querySelector('.complaint-description').textContent;
        const date = card.querySelector('.meta-item span:nth-child(2)').textContent;
        const priority = card.getAttribute('data-priority');
        const status = card.getAttribute('data-status');
        const remarks = card.querySelector('.admin-remarks')?.textContent || 'No admin remarks available.';

        // Populate view modal fields
        document.getElementById('viewId').textContent = complaintId;
        document.getElementById('viewTitle').textContent = title;
        document.getElementById('viewDescription').textContent = description;
        document.getElementById('viewDate').textContent = date;
        document.getElementById('viewPriority').textContent = priority;
        document.getElementById('viewStatus').textContent = status;
        document.getElementById('viewAdminResponse').value = remarks;

        // Show the modal
        document.getElementById('viewModal').style.display = 'block';
    } else {
        alert('Complaint not found.');
    }
}

function closeViewModal() {
    document.getElementById('viewModal').style.display = 'none';
}

// Optional: Close modal if clicked outside
window.onclick = function(event) {
    const modal = document.getElementById('viewModal');
    if (event.target == modal) {
        modal.style.display = 'none';
    }
}
// Function to delete complaint
function deleteComplaint(complaintId) {
    if (confirm('Are you sure you want to delete this complaint?')) {
        // Find and remove the complaint card
        const card = Array.from(complaintsGrid.children).find(card =>
            card.querySelector('.complaint-id').textContent == complaintId
        );

        if (card) {
            card.remove();
            alert('Complaint deleted successfully.');
            updateStats();
            toggleEmptyState();
        } else {
            alert('Error deleting complaint.');
        }
    }
}

// Function to filter complaints by status
function filterComplaints() {
    const status = statusFilter.value.toUpperCase();
    const cards = complaintsGrid.children;

    let visibleCount = 0;
    Array.from(cards).forEach(card => {
        const cardStatus = card.querySelector('.status-badge span:last-child').textContent.toUpperCase();
        if (!status || cardStatus === status) {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });

    toggleEmptyState(visibleCount);
    updateStats();
}

// Function to toggle empty state
function toggleEmptyState(visibleCount = complaintsGrid.children.length) {
    if (visibleCount === 0) {
        emptyState.style.display = 'block';
        complaintsGrid.style.display = 'none';
    } else {
        emptyState.style.display = 'none';
        complaintsGrid.style.display = 'grid';
    }
}

// Function to update stats
function updateStats() {
    const cards = Array.from(complaintsGrid.children).filter(card =>
        card.style.display !== 'none'
    );

    const total = cards.length;
    const pending = cards.filter(card =>
        card.querySelector('.status-badge span:last-child').textContent.toUpperCase() === 'PENDING'
    ).length;
    const inProgress = cards.filter(card =>
        card.querySelector('.status-badge span:last-child').textContent.toUpperCase() === 'IN_PROGRESS'
    ).length;
    const resolved = cards.filter(card =>
        card.querySelector('.status-badge span:last-child').textContent.toUpperCase() === 'RESOLVED'
    ).length;

    document.getElementById('totalComplaints').textContent = total;
    document.getElementById('pendingComplaints').textContent = pending;
    document.getElementById('inProgressComplaints').textContent = inProgress;
    document.getElementById('resolvedComplaints').textContent = resolved;
}

// Initialize page
document.addEventListener('DOMContentLoaded', function() {
    updateStats();
    toggleEmptyState();
    statusFilter.addEventListener('change', filterComplaints);
});

// Close modals when clicking outside
window.onclick = function(event) {
    if (event.target === editModal) {
        closeEditModal();
    } else if (event.target === viewModal) {
        closeViewModal();
    }
};