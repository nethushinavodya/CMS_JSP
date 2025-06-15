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

// Add smooth focus animations
document.querySelectorAll('input').forEach(field => {
    field.addEventListener('focus', function() {
        this.closest('.form-group').style.transform = 'scale(1.02)';
    });

    field.addEventListener('blur', function() {
        this.closest('.form-group').style.transform = 'scale(1)';
    });
});

// Form submission with loading animation
document.getElementById('loginForm').addEventListener('submit', function(e) {
    const loginBtn = document.getElementById('loginBtn');

    // Add loading state
    loginBtn.classList.add('loading');
    loginBtn.disabled = true;

    // Remove loading state after form submission (in case of errors)
    setTimeout(() => {
        loginBtn.classList.remove('loading');
        loginBtn.disabled = false;
    }, 3000);
});

// Add enter key support for better UX
document.addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        const form = document.getElementById('loginForm');
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        if (username && password) {
            form.submit();
        }
    }
});

// Auto-focus on username field when page loads
window.addEventListener('load', function() {
    document.getElementById('username').focus();
});