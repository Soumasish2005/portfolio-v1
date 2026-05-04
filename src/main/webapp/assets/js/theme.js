/**
 * theme.js — Dark / Light mode toggle
 * Persists preference to localStorage.
 * Applies to <html data-theme="dark|light">
 */
(function () {
    const STORAGE_KEY = 'portfolio-theme';
    const DARK = 'dark';
    const LIGHT = 'light';

    // ── Apply saved or system preference on load ──────────
    const saved = localStorage.getItem(STORAGE_KEY);
    const system = window.matchMedia('(prefers-color-scheme: dark)').matches
        ? DARK : LIGHT;
    const initial = saved || system;

    document.documentElement.setAttribute('data-theme', initial);

    // ── Toggle ────────────────────────────────────────────
    function toggleTheme() {
        const current = document.documentElement.getAttribute('data-theme');
        const next = current === DARK ? LIGHT : DARK;
        document.documentElement.setAttribute('data-theme', next);
        localStorage.setItem(STORAGE_KEY, next);
        updateIcon(next);
    }

    // ── Icon swap ────────────────────────────────────────
    function updateIcon(theme) {
        const btn = document.getElementById('themeToggle');
        if (!btn) return;
        btn.innerHTML = theme === DARK ? sunIcon() : moonIcon();
        btn.setAttribute('aria-label',
            theme === DARK ? 'Switch to light mode' : 'Switch to dark mode');
    }

    function moonIcon() {
        return `<svg xmlns="http://www.w3.org/2000/svg" fill="none"
                     viewBox="0 0 24 24" stroke-width="1.8" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round"
                        d="M21.752 15.002A9 9 0 1112.998 2.248
                           7 7 0 0021.752 15.002z"/>
                </svg>`;
    }

    function sunIcon() {
        return `<svg xmlns="http://www.w3.org/2000/svg" fill="none"
                     viewBox="0 0 24 24" stroke-width="1.8" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round"
                        d="M12 3v1m0 16v1m9-9h-1M4 12H3
                           m15.364-6.364l-.707.707M6.343 17.657l-.707.707
                           M17.657 17.657l-.707-.707M6.343 6.343l-.707-.707
                           M12 7a5 5 0 100 10A5 5 0 0012 7z"/>
                </svg>`;
    }

    // ── Mobile menu ──────────────────────────────────────
    function initMobileMenu() {
        const btn = document.getElementById('navHamburger');
        const menu = document.getElementById('mobileMenu');
        if (!btn || !menu) return;

        btn.addEventListener('click', () => {
            const open = menu.classList.toggle('open');
            btn.setAttribute('aria-expanded', String(open));
        });
    }

    // ── Init on DOM ready ────────────────────────────────
    document.addEventListener('DOMContentLoaded', () => {
        updateIcon(initial);

        const toggle = document.getElementById('themeToggle');
        if (toggle) toggle.addEventListener('click', toggleTheme);

        initMobileMenu();

        // Mark active nav link
        const links = document.querySelectorAll('.nav__links a, .nav__mobile-menu a');
        links.forEach(link => {
            if (link.href === window.location.href ||
                window.location.pathname.startsWith(
                    new URL(link.href).pathname)) {
                link.classList.add('active');
            }
        });
    });
})();