# Mobile Responsive Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement mobile-responsive layout for OHPG website (< 768px) with hamburger menu, streamlined Hero, vertical project stacking, and segmented device controls.

**Architecture:** Single-page Jekyll site with CSS media queries for mobile breakpoints. Hamburger menu via JS toggle. Canvas particle count reduced on mobile.

**Tech Stack:** Vanilla CSS (media queries), Vanilla JS (menu toggle), existing AOS library, Canvas API

---

## File Modification Map

| File | Changes |
|------|---------|
| `assets/css/style.css` | Add mobile styles (hamburger, Hero, cards, segmented tabs) |
| `index.md` | Add hamburger menu HTML, JS menu toggle |
| `_layouts/default.html` | No changes needed |

---

## Task 1: Add Mobile Navigation (Hamburger Menu)

**Files:**
- Modify: `index.md` (add menu HTML before `.hero`)
- Modify: `assets/css/style.css` (add mobile nav styles)
- Modify: `index.md` (add JS toggle logic to existing `<script>`)

### Steps:

- [ ] **Step 1: Add hamburger menu HTML to index.md**

Find this line in `index.md`:
```html
<div class="hero">
```

Add BEFORE it:
```html
<!-- Mobile Navigation -->
<div class="mobile-nav">
  <div class="mobile-nav-bar">
    <div class="logo">OHPG</div>
    <button class="hamburger" aria-label="Toggle menu">
      <span class="hamburger-line"></span>
      <span class="hamburger-line"></span>
      <span class="hamburger-line"></span>
    </button>
  </div>
  <div class="mobile-nav-overlay">
    <nav class="mobile-nav-links">
      {% for project in site.data.summary.projects %}
      <a href="{{ project.link }}" class="mobile-nav-link">{{ project.name }}</a>
      {% endfor %}
      <a href="https://github.com/OHPG" target="_blank" class="mobile-nav-link">
        <i class="ri-github-fill"></i> GitHub
      </a>
    </nav>
  </div>
</div>
```

- [ ] **Step 2: Add mobile navigation CSS to style.css**

Add at the end of `style.css` (before line 1110):

```css
/* ============================================
   Mobile Navigation (Hamburger Menu)
   ============================================ */

.mobile-nav {
  display: none;
}

.mobile-nav-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.5rem;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
}

.mobile-nav-bar .logo {
  font-size: 1.5rem;
  background: var(--gradient);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hamburger {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 24px;
  height: 18px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
  z-index: 1001;
}

.hamburger-line {
  display: block;
  width: 100%;
  height: 2px;
  background: var(--text);
  transition: all 0.3s ease;
}

.mobile-nav-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  z-index: 999;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.mobile-nav-overlay.active {
  opacity: 1;
  visibility: visible;
}

.mobile-nav-links {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2rem;
}

.mobile-nav-link {
  font-size: 1.5rem;
  color: var(--text);
  text-decoration: none;
  transition: color 0.3s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.mobile-nav-link:hover {
  color: var(--primary);
}

/* Hamburger animation when open */
.hamburger.active .hamburger-line:nth-child(1) {
  transform: translateY(8px) rotate(45deg);
}

.hamburger.active .hamburger-line:nth-child(2) {
  opacity: 0;
}

.hamburger.active .hamburger-line:nth-child(3) {
  transform: translateY(-8px) rotate(-45deg);
}
```

- [ ] **Step 3: Add hamburger toggle JavaScript to index.md**

Find the existing `document.addEventListener('DOMContentLoaded', function() {` in `index.md` and add at the BEGINNING of the function (after line 148):

```javascript
// Mobile Navigation Toggle
const hamburger = document.querySelector('.hamburger');
const mobileNavOverlay = document.querySelector('.mobile-nav-overlay');

if (hamburger && mobileNavOverlay) {
  hamburger.addEventListener('click', function() {
    hamburger.classList.toggle('active');
    mobileNavOverlay.classList.toggle('active');
    document.body.style.overflow = mobileNavOverlay.classList.contains('active') ? 'hidden' : '';
  });

  // Close menu when clicking a link
  mobileNavOverlay.querySelectorAll('.mobile-nav-link').forEach(link => {
    link.addEventListener('click', function() {
      hamburger.classList.remove('active');
      mobileNavOverlay.classList.remove('active');
      document.body.style.overflow = '';
    });
  });
}
```

---

## Task 2: Style Mobile Hero Section

**Files:**
- Modify: `assets/css/style.css` (add mobile Hero styles)
- Modify: `index.md` (hide project-list on mobile)

### Steps:

- [ ] **Step 1: Add mobile Hero CSS to style.css inside @media (max-width: 768px)**

Find the existing `@media (max-width: 768px)` block in `style.css` (around line 344) and ADD these styles inside it:

```css
/* Hero Mobile */
.hero {
  min-height: auto;
  padding: 80px 1rem 2rem;
}

.hero-content h1 {
  font-size: 2rem;
  line-height: 1.3;
}

.subtitle {
  font-size: 0.9rem;
  margin-bottom: 1.5rem;
}

.logo {
  font-size: 3rem;
}

.summary-stats {
  flex-wrap: wrap;
  gap: 1rem;
  justify-content: center;
}

.stat-item {
  padding: 0.5rem 1rem;
}

.project-list {
  display: none;
}
```

---

## Task 3: Style Mobile Project Cards

**Files:**
- Modify: `assets/css/style.css` (add mobile project card styles)

### Steps:

- [ ] **Step 1: Add mobile project card CSS inside @media (max-width: 768px)**

Add to the `@media (max-width: 768px)` block:

```css
/* Project Cards Mobile */
.project-showcase {
  padding: 2rem 0;
}

.project-header {
  margin-bottom: 2rem;
}

.project-title {
  font-size: 1.8rem;
}

.project-meta {
  flex-direction: column;
  gap: 0.8rem;
  align-items: center;
}

.project-description {
  font-size: 0.95rem;
  padding: 0 1rem;
}
```

---

## Task 4: Style Mobile Segmented Device Tabs

**Files:**
- Modify: `assets/css/style.css` (add mobile segmented control styles)

### Steps:

- [ ] **Step 1: Add mobile segmented control CSS inside @media (max-width: 768px)**

Add to the `@media (max-width: 768px)` block:

```css
/* Device Tabs Mobile - Segmented Control Style */
.devices-tabs {
  background: var(--card-bg);
  padding: 4px;
  gap: 4px;
}

.devices-tabs::before {
  display: none;
}

.device-tab {
  flex: 1;
  padding: 0.6rem 0.5rem;
  font-size: 0.85rem;
  border-radius: 6px;
  background: transparent;
}

.device-tab.active {
  background: var(--primary);
  color: #000;
  font-weight: 600;
}

.device-tab.active i {
  transform: none;
}

.device-tab:not(.active) {
  color: var(--text);
  opacity: 0.7;
}

.device-tab:hover:not(.active) {
  background: rgba(255, 255, 255, 0.05);
  color: var(--text);
}
```

---

## Task 5: Style Mobile Preview Images

**Files:**
- Modify: `assets/css/style.css` (add mobile preview styles)

### Steps:

- [ ] **Step 1: Add mobile preview CSS inside @media (max-width: 768px)**

Add to the `@media (max-width: 768px)` block:

```css
/* Preview Images Mobile */
.devices-section {
  padding: 1rem;
}

.device-preview {
  grid-template-columns: 1fr;
  gap: 1.5rem;
}

.preview-images {
  width: 100%;
  max-width: 280px;
  height: auto;
  aspect-ratio: 9/16;
  margin: 0 auto;
  border-radius: 20px;
  background: linear-gradient(135deg, #1a1a1a, #2a2a2a);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.preview-images:hover {
  transform: none;
}

.preview-img {
  width: 90%;
  max-height: 95%;
  object-fit: contain;
}

.preview-indicators {
  padding-left: 0;
  max-height: 120px;
  overflow-y: auto;
}

.indicator {
  padding: 0.4rem 0.8rem;
}

.indicator h3 {
  font-size: 0.9rem;
}

.indicator p {
  font-size: 0.8rem;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
```

---

## Task 6: Add Canvas Performance Optimization for Mobile

**Files:**
- Modify: `index.md` (reduce particle count on mobile)

### Steps:

- [ ] **Step 1: Update particle count logic in index.md**

Find this line in the Canvas section:
```javascript
const particleCount = Math.min(window.innerWidth / 20, 40);
```

Replace with:
```javascript
const isMobile = window.innerWidth < 768;
const particleCount = isMobile ? 15 : Math.min(window.innerWidth / 20, 40);
```

---

## Task 7: Final Mobile CSS Tweaks

**Files:**
- Modify: `assets/css/style.css` (footer and general mobile tweaks)

### Steps:

- [ ] **Step 1: Add final mobile CSS tweaks**

Add to the `@media (max-width: 768px)` block:

```css
/* Footer Mobile */
.site-footer {
  padding: 1.5rem 0;
}

.footer-content {
  flex-direction: column;
  gap: 0.5rem;
  height: auto;
  padding: 1rem;
}

.copyright, .beian {
  font-size: 0.75rem;
}

/* GitHub Corner Mobile */
.github-corner {
  display: none;
}

/* Body Mobile */
body {
  margin: 0;
}
```

---

## Task 8: Build and Verify

### Steps:

- [ ] **Step 1: Build the Jekyll site**

Run: `bundle exec jekyll build`

- [ ] **Step 2: Start local server**

Run: `bundle exec jekyll serve --watch`

- [ ] **Step 3: Verify with browser dev tools**

1. Open http://localhost:4000
2. Set viewport to 375px (iPhone SE)
3. Check all modules render correctly
4. Toggle hamburger menu
5. Switch device tabs (mobile/tablet/desktop)
6. Verify no horizontal overflow

---

## Verification Checklist

- [ ] Mobile nav hamburger opens/closes correctly
- [ ] Hero section shows Logo + stats (no horizontal project icons)
- [ ] Project cards stack vertically
- [ ] Device tabs show segmented control style
- [ ] Preview images scale correctly
- [ ] Canvas background renders without lag
- [ ] Footer displays correctly
- [ ] No horizontal scroll on mobile
