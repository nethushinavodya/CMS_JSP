// Modal handling
function openModal() {
    document.getElementById('adminModal').style.display = 'block';
    document.getElementById('adminForm').reset();
    document.getElementById('previewImg').style.display = 'none';
    document.getElementById('placeholderIcon').style.display = 'block';
    document.getElementById('imagePreview').classList.remove('has-image');
}

function closeModal() {
    document.getElementById('adminModal').style.display = 'none';
}

// Image preview
function previewImage(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const previewImg = document.getElementById('previewImg');
            previewImg.src = e.target.result;
            previewImg.style.display = 'block';
            document.getElementById('placeholderIcon').style.display = 'none';
            document.getElementById('imagePreview').classList.add('has-image');
        };
        reader.readAsDataURL(file);
    }
}

// Password toggle
function togglePassword(fieldId) {
    const input = document.getElementById(fieldId);
    const icon = input.nextElementSibling.querySelector('i');
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}

// Display feedback messages from query parameters
window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');
    const message = urlParams.get('message');
    if (status && message) {
        Swal.fire({
            icon: status === 'success' ? 'success' : 'error',
            title: status === 'success' ? 'Success' : 'Error',
            text: decodeURIComponent(message).replace(/\+/g, ' '),
            confirmButtonColor: '#ff8c00'
        });
        // Clear query parameters from URL
        window.history.replaceState({}, document.title, window.location.pathname);
    }
};

// Form submission validation (client-side)
document.getElementById('adminForm').addEventListener('submit', function(e) {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    if (password !== confirmPassword) {
        e.preventDefault();
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Passwords do not match',
            confirmButtonColor: '#ff8c00'
        });
    }
});