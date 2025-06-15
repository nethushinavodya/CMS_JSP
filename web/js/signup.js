
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

function checkPasswordStrength(password) {
    let strength = 0;
    if (password.length >= 8) strength++;
    if (password.match(/[a-z]+/)) strength++;
    if (password.match(/[A-Z]+/)) strength++;
    if (password.match(/[0-9]+/)) strength++;
    if (password.match(/[$@#&!]+/)) strength++;

    return strength;
}

document.getElementById('password').addEventListener('input', function(e) {
    const password = e.target.value;
    const strength = checkPasswordStrength(password);
    const strengthFill = document.getElementById('strengthFill');

    strengthFill.className = 'strength-fill';

    if (strength <= 2) {
        strengthFill.classList.add('strength-weak');
    } else if (strength === 3) {
        strengthFill.classList.add('strength-fair');
    } else if (strength === 4) {
        strengthFill.classList.add('strength-good');
    } else {
        strengthFill.classList.add('strength-strong');
    }
});

document.getElementById('signupForm').addEventListener('submit', function(e) {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm_password').value;

    if (password !== confirmPassword) {
        e.preventDefault();
        alert('Passwords do not match. Please try again.');
        document.getElementById('confirm_password').focus();
    }
});

// Add smooth focus animations
document.querySelectorAll('input, textarea').forEach(field => {
    field.addEventListener('focus', function() {
        this.parentElement.style.transform = 'scale(1.02)';
    });

    field.addEventListener('blur', function() {
        this.parentElement.style.transform = 'scale(1)';
    });
});

// Profile image upload functionality - Fixed
document.getElementById('imagePreview').addEventListener('click', function() {
    document.getElementById('profile_image').click();
});

document.getElementById('profile_image').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
        // Validate file type
        if (!file.type.startsWith('image/')) {
            alert('Please select a valid image file.');
            this.value = '';
            return;
        }

        // Validate file size (max 5MB)
        if (file.size > 5 * 1024 * 1024) {
            alert('Image size should be less than 5MB.');
            this.value = '';
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById('imagePreview');
            const img = document.getElementById('previewImg');
            const placeholder = document.getElementById('placeholderIcon');
            const overlay = document.getElementById('imageOverlay');

            img.src = e.target.result;
            img.style.display = 'block';
            placeholder.style.display = 'none';
            overlay.style.display = 'flex';
            preview.classList.add('has-image');
        };
        reader.readAsDataURL(file);
    }
});

function removeImage() {
    const preview = document.getElementById('imagePreview');
    const img = document.getElementById('previewImg');
    const placeholder = document.getElementById('placeholderIcon');
    const overlay = document.getElementById('imageOverlay');
    const fileInput = document.getElementById('profile_image');

    img.style.display = 'none';
    img.src = '';
    placeholder.style.display = 'flex';
    overlay.style.display = 'none';
    preview.classList.remove('has-image');
    fileInput.value = '';
}