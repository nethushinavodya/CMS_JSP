// Form validation and enhancement
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('complaintForm');
    const titleInput = document.getElementById('title');
    const descriptionInput = document.getElementById('description');
    const titleCounter = document.getElementById('titleCounter');
    const descriptionCounter = document.getElementById('descriptionCounter');

    // Character counters
    function updateCounter(input, counter, maxLength) {
        const current = input.value.length;
        counter.textContent = `${current} / ${maxLength}`;
        counter.style.color = current > maxLength * 0.9 ? '#ff8c00' : '#888';
    }

    // Form submission handling
    form.addEventListener('submit', function(e) {
        // Basic validation
        if (!titleInput.value.trim()) {
            e.preventDefault();
            alert('Please enter a complaint title.');
            titleInput.focus();
            return;
        }

        if (!descriptionInput.value.trim()) {
            e.preventDefault();
            alert('Please provide a detailed description.');
            descriptionInput.focus();
            return;
        }

        if (!document.querySelector('input[name="priority"]:checked')) {
            e.preventDefault();
            alert('Please select a priority level.');
            document.getElementById('priorityHigh').focus();
            return;
        }

        // Show loading state
        const submitBtn = document.querySelector('.btn-primary');
        submitBtn.innerHTML = '⏳ Submitting...';
        submitBtn.disabled = true;

        // Simulate form submission (replace with your actual submission logic)
        setTimeout(function() {
            submitBtn.innerHTML = '📤 Submit Complaint';
            submitBtn.disabled = false;
            alert('Complaint submitted successfully!');
            form.reset();
        }, 2000);

        // Form will submit to SubmitComplaintServlet
    });
});