// Sample admin data
let admins = [
    {
        id: 1,
        fullName: "John Smith",
        username: "johnsmith",
        email: "john@company.com",
        address: "123 Main St, New York, NY 10001",
        employeeId: "EMP001",
        role: "ADMIN",
        profilePic: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
        password: "password123",
        confirmPassword: "password123"
    },
    {
        id: 2,
        fullName: "Sarah Johnson",
        username: "sarahj",
        email: "sarah@company.com",
        address: "456 Oak Ave, Los Angeles, CA 90210",
        employeeId: "EMP002",
        role: "ADMIN",
        profilePic: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
        password: "admin456",
        confirmPassword: "admin456"
    }
];

let currentEditId = null;

function updateStats() {
    document.getElementById('totalAdmins').textContent = admins.length;
    document.getElementById('activeAdmins').textContent = admins.length;
    document.getElementById('newAdmins').textContent = Math.floor(Math.random() * 3);
}

function renderAdmins() {
    const tbody = document.getElementById('adminTableBody');
    tbody.innerHTML = '';

    admins.forEach(admin => {
        const row = document.createElement('tr');
        row.innerHTML = `
                    <td>
                        <img src="${admin.profilePic || 'https://via.placeholder.com/50x50/ff8c00/000000?text=' + admin.fullName.charAt(0)}"
                             alt="${admin.fullName}" class="profile-pic">
                    </td>
                    <td>${admin.fullName}</td>
                    <td>${admin.username}</td>
                    <td>${admin.email}</td>
                    <td>${admin.address}</td>
                    <td>${admin.employeeId}</td>
                    <td><span class="role-badge">${admin.role}</span></td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-edit" onclick="editAdmin(${admin.id})">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            <button class="btn btn-delete" onclick="deleteAdmin(${admin.id})">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </div>
                    </td>
                `;
        tbody.appendChild(row);
    });

    updateStats();
}

function openModal(mode, adminId = null) {
    const modal = document.getElementById('adminModal');
    const modalTitle = document.getElementById('modalTitle');
    const submitBtn = document.getElementById('submitBtn');
    const form = document.getElementById('adminForm');

    if (mode === 'add') {
        modalTitle.textContent = 'Add New Admin';
        submitBtn.textContent = 'Add Admin';
        form.reset();
        resetImagePreview();
        currentEditId = null;
    } else if (mode === 'edit') {
        modalTitle.textContent = 'Edit Admin';
        submitBtn.textContent = 'Update Admin';
        currentEditId = adminId;
        populateForm(adminId);
    }

    modal.style.display = 'block';
}

function closeModal() {
    document.getElementById('adminModal').style.display = 'none';
    document.getElementById('adminForm').reset();
    resetImagePreview();
    currentEditId = null;
}

function populateForm(adminId) {
    const admin = admins.find(a => a.id === adminId);
    if (admin) {
        document.getElementById('fullName').value = admin.fullName;
        document.getElementById('username').value = admin.username;
        document.getElementById('email').value = admin.email;
        document.getElementById('address').value = admin.address;
        document.getElementById('employeeId').value = admin.employeeId;
        document.getElementById('password').value = admin.password;
        document.getElementById('confirmPassword').value = admin.confirmPassword;

        if (admin.profilePic) {
            const previewImg = document.getElementById('previewImg');
            const placeholderIcon = document.getElementById('placeholderIcon');

            previewImg.src = admin.profilePic;
            previewImg.style.display = 'block';
            placeholderIcon.style.display = 'none';
            document.getElementById('imagePreview').classList.add('has-image');
        }
    }
}

function resetImagePreview() {
    const previewImg = document.getElementById('previewImg');
    const placeholderIcon = document.getElementById('placeholderIcon');
    const imagePreview = document.getElementById('imagePreview');

    previewImg.style.display = 'none';
    previewImg.src = '';
    placeholderIcon.style.display = 'block';
    imagePreview.classList.remove('has-image');
    document.getElementById('profilePic').value = '';
}

function previewImage(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const previewImg = document.getElementById('previewImg');
            const placeholderIcon = document.getElementById('placeholderIcon');

            previewImg.src = e.target.result;
            previewImg.style.display = 'block';
            placeholderIcon.style.display = 'none';
            document.getElementById('imagePreview').classList.add('has-image');
        };
        reader.readAsDataURL(file);
    }
}

function togglePassword(fieldId) {
    const field = document.getElementById(fieldId);
    const icon = field.nextElementSibling.querySelector('i');

    if (field.type === 'password') {
        field.type = 'text';
        icon.className = 'fas fa-eye-slash';
    } else {
        field.type = 'password';
        icon.className = 'fas fa-eye';
    }
}

function editAdmin(adminId) {
    openModal('edit', adminId);
}

function deleteAdmin(adminId) {
    if (confirm('Are you sure you want to delete this admin? This action cannot be undone.')) {
        admins = admins.filter(admin => admin.id !== adminId);
        renderAdmins();
    }
}

function searchAdmins() {
    // Search functionality removed - no longer needed
}

// Event listeners
// Search event listener removed

document.getElementById('adminForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const formData = {
        fullName: document.getElementById('fullName').value,
        username: document.getElementById('username').value,
        email: document.getElementById('email').value,
        address: document.getElementById('address').value,
        employeeId: document.getElementById('employeeId').value,
        role: 'ADMIN', // Default role set to ADMIN
        password: document.getElementById('password').value,
        confirmPassword: document.getElementById('confirmPassword').value,
        profilePic: document.getElementById('previewImg').src || null
    };

    // Validation
    if (formData.password !== formData.confirmPassword) {
        alert('Passwords do not match!');
        return;
    }

    // Check for duplicate username or email
    const isDuplicate = admins.some(admin =>
        (admin.username === formData.username || admin.email === formData.email) &&
        admin.id !== currentEditId
    );

    if (isDuplicate) {
        alert('Username or email already exists!');
        return;
    }

    if (currentEditId) {
        // Update existing admin
        const adminIndex = admins.findIndex(admin => admin.id === currentEditId);
        if (adminIndex !== -1) {
            admins[adminIndex] = { ...formData, id: currentEditId };
        }
    } else {
        // Add new admin
        const newAdmin = {
            ...formData,
            id: Date.now() // Simple ID generation
        };
        admins.push(newAdmin);
    }

    renderAdmins();
    closeModal();
});

// Close modal when clicking outside
window.onclick = function(event) {
    const modal = document.getElementById('adminModal');
    if (event.target === modal) {
        closeModal();
    }
}

// Initialize
renderAdmins();