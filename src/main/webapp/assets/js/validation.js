/**
 * validation.js — Client-side contact form validation
 * Works alongside server-side validation in ContactServlet.java
 */
(function () {

    document.addEventListener('DOMContentLoaded', () => {
        const form = document.getElementById('contactForm');
        if (!form) return;

        // ── Per-field validators ──────────────────────────
        const rules = {
            name: {
                validate: v => v.trim().length >= 2,
                message: 'Name must be at least 2 characters.'
            },
            email: {
                validate: v => /^[\w._%+\-]+@[\w.\-]+\.[a-zA-Z]{2,}$/.test(v.trim()),
                message: 'Please enter a valid email address.'
            },
            message: {
                validate: v => v.trim().length >= 10,
                message: 'Message must be at least 10 characters.'
            }
        };

        // ── Real-time validation on blur ──────────────────
        Object.entries(rules).forEach(([name, rule]) => {
            const field = form.querySelector(`[name="${name}"]`);
            if (!field) return;
            field.addEventListener('blur', () => validateField(field, rule));
            field.addEventListener('input', () => {
                if (field.closest('.form-group').classList.contains('invalid')) {
                    validateField(field, rule);
                }
            });
        });

        // ── On submit ────────────────────────────────────
        form.addEventListener('submit', e => {
            let valid = true;

            Object.entries(rules).forEach(([name, rule]) => {
                const field = form.querySelector(`[name="${name}"]`);
                if (field && !validateField(field, rule)) valid = false;
            });

            if (!valid) {
                e.preventDefault();
                // Scroll to first error
                const first = form.querySelector('.form-group.invalid');
                if (first) first.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });

        // ── Helper ───────────────────────────────────────
        function validateField(field, rule) {
            const group = field.closest('.form-group');
            const errorEl = group.querySelector('.field-error');
            const isValid = rule.validate(field.value);

            group.classList.toggle('invalid', !isValid);
            if (errorEl) errorEl.textContent = isValid ? '' : rule.message;
            return isValid;
        }
    });

})();