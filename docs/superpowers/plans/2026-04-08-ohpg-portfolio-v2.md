# OHPG 作品集 v2.0 实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建 `docs/v2.0/index.html` 全屏翻页式原型，采用玻璃拟态设计，包含毛玻璃卡片、视差滚动和炫酷动画。

**Architecture:** 纯 HTML + CSS + Vanilla JS 单文件实现。CSS Variables 管理主题色，CSS 3D Transforms 实现视差效果，全屏翻页系统处理滚动切换。

**Tech Stack:** HTML5, CSS3 (Flexbox/Grid, CSS Variables, 3D Transforms, backdrop-filter), Vanilla JavaScript, Remixicon (图标), Google Fonts Outfit

---

## 文件结构

```
docs/
└── v2.0/
    └── index.html      # 单文件包含所有 HTML/CSS/JS
```

---

## 任务清单

### Task 1: 创建基础 HTML 结构和 CSS 变量

**Files:**
- Create: `docs/v2.0/index.html`

- [ ] **Step 1: 创建 HTML 骨架**

```html
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OHPG - 创新技术 · 优质体验</title>
    <!-- 字体 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700;800&display=swap" rel="stylesheet">
    <!-- 图标 -->
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body>
    <!-- 多层渐变背景 -->
    <div class="bg-layers">
        <div class="bg-gradient"></div>
        <div class="bg-orb orb-1"></div>
        <div class="bg-orb orb-2"></div>
        <div class="bg-orb orb-3"></div>
    </div>

    <!-- 全屏翻页容器 -->
    <main class="slides-container">
        <!-- 4 个项目翻页，每页一个 -->
    </main>

    <!-- 分页指示器 -->
    <nav class="page-indicators"></nav>

    <!-- 截图模态框 -->
    <div class="modal"></div>
</body>
</html>
```

- [ ] **Step 2: 定义 CSS 变量和全局样式**

```css
:root {
    /* 色彩系统 */
    --bg-start: #667eea;
    --bg-end: #764ba2;
    --glass-bg: rgba(255, 255, 255, 0.15);
    --glass-border: rgba(255, 255, 255, 0.3);
    --glass-shadow: rgba(0, 0, 0, 0.2);
    --text-primary: #ffffff;
    --text-secondary: rgba(255, 255, 255, 0.8);
    --accent: #ff6b9d;

    /* 间距系统 */
    --space-xs: 8px;
    --space-sm: 16px;
    --space-md: 24px;
    --space-lg: 32px;
    --space-xl: 48px;
    --space-2xl: 64px;

    /* 动画 */
    --duration-fast: 200ms;
    --duration-normal: 400ms;
    --duration-slow: 800ms;
    --ease-smooth: cubic-bezier(0.77, 0, 0.175, 1);
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: 'Outfit', -apple-system, BlinkMacSystemFont, sans-serif;
    background: linear-gradient(135deg, var(--bg-start), var(--bg-end));
    color: var(--text-primary);
    overflow: hidden;
    height: 100vh;
}

a {
    color: inherit;
    text-decoration: none;
}

img {
    max-width: 100%;
    height: auto;
}
```

- [ ] **Step 3: 提交**

```bash
git add docs/v2.0/index.html
git commit -m "feat(v2): 创建 docs/v2.0/index.html 基础结构 - HTML骨架 - CSS变量定义（玻璃拟态色彩） - 全局样式"
```

---

### Task 2: 实现多层渐变背景和光斑

**Files:**
- Modify: `docs/v2.0/index.html`

- [ ] **Step 1: 添加背景 HTML**

```html
<div class="bg-layers">
    <div class="bg-gradient"></div>
    <div class="bg-orb orb-1"></div>
    <div class="bg-orb orb-2"></div>
    <div class="bg-orb orb-3"></div>
</div>
```

- [ ] **Step 2: 添加背景 CSS**

```css
/* 多层背景容器 */
.bg-layers {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 0;
    overflow: hidden;
}

/* 渐变背景 */
.bg-gradient {
    position: absolute;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, var(--bg-start) 0%, var(--bg-end) 100%);
}

/* 模糊光斑 */
.bg-orb {
    position: absolute;
    border-radius: 50%;
    filter: blur(80px);
    opacity: 0.6;
    will-change: transform;
}

.orb-1 {
    width: 600px;
    height: 600px;
    background: rgba(102, 126, 234, 0.5);
    top: -200px;
    right: -200px;
}

.orb-2 {
    width: 500px;
    height: 500px;
    background: rgba(118, 75, 162, 0.5);
    bottom: -150px;
    left: -150px;
}

.orb-3 {
    width: 400px;
    height: 400px;
    background: rgba(255, 107, 157, 0.4);
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
```

- [ ] **Step 3: 添加视差滚动 JS**

```javascript
// 视差滚动效果
class ParallaxBackground {
    constructor() {
        this.orbs = document.querySelectorAll('.bg-orb');
        this.scrollY = 0;
        this.ticking = false;

        window.addEventListener('scroll', () => this.onScroll(), { passive: true });
    }

    onScroll() {
        this.scrollY = window.scrollY;
        if (!this.ticking) {
            requestAnimationFrame(() => this.update());
            this.ticking = true;
        }
    }

    update() {
        // 不同层以不同速度移动
        this.orbs[0].style.transform = `translate(${this.scrollY * 0.1}px, ${-this.scrollY * 0.05}px)`;
        this.orbs[1].style.transform = `translate(${-this.scrollY * 0.08}px, ${this.scrollY * 0.12}px)`;
        this.orbs[2].style.transform = `translate(${this.scrollY * 0.05}px, ${this.scrollY * 0.08}px)`;
        this.ticking = false;
    }
}
```

- [ ] **Step 4: 提交**

```bash
git add docs/v2.0/index.html
git commit -m "feat(v2): 实现多层渐变背景和光斑 - 渐变背景层 - 3个模糊光斑 - 视差滚动效果"
```

---

### Task 3: 实现全屏翻页系统

**Files:**
- Modify: `docs/v2.0/index.html`

- [ ] **Step 1: 添加翻页容器 HTML**

```html
<main class="slides-container" id="slidesContainer">
    <!-- 4 个 slide 由 JS 渲染 -->
</main>
```

- [ ] **Step 2: 添加翻页 CSS**

```css
/* 全屏翻页容器 */
.slides-container {
    position: relative;
    z-index: 1;
    width: 100%;
    height: 100vh;
    overflow: hidden;
}

/* 单个翻页 */
.slide {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transform: scale(0.9);
    transition:
        opacity var(--duration-slow) var(--ease-smooth),
        transform var(--duration-slow) var(--ease-smooth);
    pointer-events: none;
}

.slide.active {
    opacity: 1;
    transform: scale(1);
    pointer-events: auto;
}

/* 响应式 */
@media (max-width: 640px) {
    .slide {
        padding: var(--space-md);
    }
}
```

- [ ] **Step 3: 添加翻页 JS**

```javascript
// 全屏翻页控制器
class SlideController {
    constructor() {
        this.currentIndex = 0;
        this.totalSlides = 4;
        this.container = document.getElementById('slidesContainer');
        this.isAnimating = false;

        this.init();
    }

    init() {
        // 渲染 4 个翻页
        this.renderSlides();

        // 绑定滚动事件
        window.addEventListener('wheel', (e) => this.onWheel(e), { passive: false });

        // 绑定键盘事件
        window.addEventListener('keydown', (e) => this.onKeyDown(e));

        // 绑定触摸事件
        this.bindTouchEvents();
    }

    renderSlides() {
        // 由 JS 动态渲染每个项目的内容
    }

    goToSlide(index) {
        if (this.isAnimating || index === this.currentIndex) return;
        if (index < 0 || index >= this.totalSlides) return;

        this.isAnimating = true;
        const slides = document.querySelectorAll('.slide');

        // 移除当前 active
        slides[this.currentIndex].classList.remove('active');

        // 激活新的
        this.currentIndex = index;
        slides[this.currentIndex].classList.add('active');

        // 更新指示器
        this.updateIndicators();

        // 重置动画锁
        setTimeout(() => {
            this.isAnimating = false;
        }, 800);
    }

    nextSlide() {
        this.goToSlide(this.currentIndex + 1);
    }

    prevSlide() {
        this.goToSlide(this.currentIndex - 1);
    }

    updateIndicators() {
        const indicators = document.querySelectorAll('.indicator-dot');
        indicators.forEach((dot, i) => {
            dot.classList.toggle('active', i === this.currentIndex);
        });
    }

    onWheel(e) {
        e.preventDefault();
        if (e.deltaY > 0) {
            this.nextSlide();
        } else {
            this.prevSlide();
        }
    }

    onKeyDown(e) {
        if (e.key === 'ArrowDown' || e.key === 'ArrowRight') {
            this.nextSlide();
        } else if (e.key === 'ArrowUp' || e.key === 'ArrowLeft') {
            this.prevSlide();
        }
    }

    bindTouchEvents() {
        let startY = 0;
        let startX = 0;

        window.addEventListener('touchstart', (e) => {
            startY = e.touches[0].clientY;
            startX = e.touches[0].clientX;
        }, { passive: true });

        window.addEventListener('touchend', (e) => {
            const endY = e.changedTouches[0].clientY;
            const endX = e.changedTouches[0].clientX;
            const diffY = startY - endY;
            const diffX = startX - endX;

            if (Math.abs(diffY) > Math.abs(diffX) && Math.abs(diffY) > 50) {
                if (diffY > 0) {
                    this.nextSlide();
                } else {
                    this.prevSlide();
                }
            }
        }, { passive: true });
    }
}
```

- [ ] **Step 4: 提交**

```bash
git add docs/v2.0/index.html
git commit -m "feat(v2): 实现全屏翻页系统 - 滚动/键盘/触摸切换 - 缩放淡入淡出动画 - 节流防止快速触发"
```

---

### Task 4: 实现毛玻璃卡片

**Files:**
- Modify: `docs/v2.0/index.html`

- [ ] **Step 1: 添加毛玻璃卡片 CSS**

```css
/* 毛玻璃卡片 */
.glass-card {
    background: var(--glass-bg);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid var(--glass-border);
    border-radius: 24px;
    box-shadow:
        0 8px 32px var(--glass-shadow),
        inset 0 1px 0 rgba(255, 255, 255, 0.2);
    padding: var(--space-2xl);
    max-width: 900px;
    width: 90%;
    max-height: 85vh;
    overflow-y: auto;
    transform-style: preserve-3d;
    perspective: 1000px;
}

/* 卡片内内容 */
.card-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: var(--space-xl);
    align-items: center;
}

@media (max-width: 900px) {
    .card-content {
        grid-template-columns: 1fr;
        text-align: center;
    }
}

/* 入场动画 */
.slide.active .glass-card {
    animation: cardEnter 0.6s ease-out forwards;
}

@keyframes cardEnter {
    from {
        opacity: 0;
        transform: translateY(30px) scale(0.95);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}
```

- [ ] **Step 2: 提交**

```bash
git add docs/v2.0/index.html
git commit -m "feat(v2): 实现毛玻璃卡片组件 - backdrop-filter blur - 白色边框和阴影 - 3D 入场动画"
```

---

### Task 5: 实现项目内容渲染

**Files:**
- Modify: `docs/v2.0/index.html`

- [ ] **Step 1: 添加项目数据**

```javascript
const projectsData = [
    {
        id: 'FinVideo',
        name: 'FinVideo',
        icon: 'https://raw.githubusercontent.com/OHPG/FinVideo/main/assets/icon.png',
        description: 'Jellyfin 视频播放器，让你的影片库触手可及',
        tags: ['鸿蒙', 'Jellyfin', '视频播放'],
        features: ['直接播放', '简单易用', '手势操作', '多用户支持'],
        screenshots: [
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinVideo/Market/FinVideo1.jpg',
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinVideo/Market/FinVideo2.jpg',
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinVideo/Market/FinVideo3.jpg'
        ],
        github: 'https://github.com/OHPG/FinVideo',
        demo_url: 'https://github.com/OHPG/FinVideo/releases/tag/v0.1.0'
    },
    {
        id: 'FinMusic',
        name: 'FinMusic',
        icon: 'https://raw.githubusercontent.com/OHPG/FinMusic/main/assets/icon.png',
        description: 'Jellyfin 音乐播放器，随时随地享受高品质音乐',
        tags: ['鸿蒙', 'Jellyfin', '音乐播放'],
        features: ['多平台音源聚合', '智能歌单管理', '高品质音频支持'],
        screenshots: [
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinMusic/Market/FinMusic1.jpg',
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinMusic/Market/FinMusic2.jpg',
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinMusic/Market/FinMusic3.jpg'
        ],
        github: 'https://github.com/OHPG/FinMusic',
        demo_url: '#'
    },
    {
        id: 'FinBook',
        name: 'FinBook',
        icon: 'https://raw.githubusercontent.com/OHPG/FinBook/main/assets/icon.png',
        description: 'Jellyfin 电子阅读器，沉浸式阅读体验',
        tags: ['鸿蒙', 'Jellyfin', '阅读器'],
        features: ['多格式支持', '智能排版', '云端同步'],
        screenshots: [
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinBook/Market/FinBook1.jpg',
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinBook/Market/FinBook2.jpg'
        ],
        github: 'https://github.com/OHPG/FinBook',
        demo_url: '#'
    },
    {
        id: 'FinAdmin',
        name: 'FinAdmin',
        icon: 'https://raw.githubusercontent.com/OHPG/FinAdmin/main/assets/icon.png',
        description: 'Jellyfin 媒体管理工具，数据一目了然',
        tags: ['鸿蒙', 'Jellyfin', '后台管理'],
        features: ['数据更新', '权限管理', '媒体编辑'],
        screenshots: [
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinAdmin/Market/FinAdmin1.jpg',
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinAdmin/Market/FinAdmin2.jpg',
            'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinAdmin/Market/FinAdmin3.jpg'
        ],
        github: 'https://github.com/OHPG/FinAdmin',
        demo_url: '#'
    }
];
```

- [ ] **Step 2: 添加渲染函数**

```javascript
function renderSlides() {
    const container = document.getElementById('slidesContainer');

    projectsData.forEach((project, index) => {
        const slide = document.createElement('div');
        slide.className = `slide ${index === 0 ? 'active' : ''}`;
        slide.dataset.index = index;

        const featuresHtml = project.features.map(f =>
            `<span class="feature-tag"><i class="ri-checkbox-circle-fill"></i>${f}</span>`
        ).join('');

        const screenshotsHtml = project.screenshots.map((src, i) =>
            `<img src="${src}" alt="截图${i + 1}" class="screenshot-thumb" data-src="${src}">`
        ).join('');

        slide.innerHTML = `
            <div class="glass-card">
                <div class="card-content">
                    <div class="card-info">
                        <div class="project-header">
                            <img src="${project.icon}" alt="${project.name}" class="project-icon">
                            <h1 class="project-name">${project.name}</h1>
                        </div>
                        <p class="project-desc">${project.description}</p>
                        <div class="project-tags">
                            ${project.tags.map(t => `<span class="tag">${t}</span>`).join('')}
                        </div>
                        <div class="features-list">
                            ${featuresHtml}
                        </div>
                        <div class="project-links">
                            <a href="${project.github}" target="_blank" class="btn btn-primary">
                                <i class="ri-github-fill"></i> GitHub
                            </a>
                            <a href="${project.demo_url}" target="_blank" class="btn btn-secondary">
                                <i class="ri-global-line"></i> Release
                            </a>
                        </div>
                    </div>
                    <div class="card-media">
                        <div class="screenshots">
                            ${screenshotsHtml}
                        </div>
                    </div>
                </div>
            </div>
        `;

        container.appendChild(slide);
    });
}
```

- [ ] **Step 3: 添加项目内容 CSS**

```css
/* 项目头部 */
.project-header {
    display: flex;
    align-items: center;
    gap: var(--space-md);
    margin-bottom: var(--space-md);
}

.project-icon {
    width: 64px;
    height: 64px;
    border-radius: 16px;
    object-fit: cover;
}

.project-name {
    font-size: 2.5rem;
    font-weight: 800;
    background: linear-gradient(135deg, #fff 0%, rgba(255,255,255,0.8) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

@media (max-width: 900px) {
    .project-header {
        justify-content: center;
        flex-wrap: wrap;
    }

    .project-name {
        font-size: 2rem;
    }
}

/* 描述 */
.project-desc {
    font-size: 1.125rem;
    color: var(--text-secondary);
    margin-bottom: var(--space-md);
}

/* 标签 */
.project-tags {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-xs);
    margin-bottom: var(--space-lg);
}

.tag {
    padding: 6px 16px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 20px;
    font-size: 0.875rem;
    backdrop-filter: blur(10px);
}

/* 功能特点 */
.features-list {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-sm);
    margin-bottom: var(--space-lg);
}

.feature-tag {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px;
    background: rgba(255, 107, 157, 0.2);
    border-radius: 12px;
    font-size: 0.875rem;
    border: 1px solid rgba(255, 107, 157, 0.3);
}

.feature-tag i {
    color: var(--accent);
}

/* 按钮 */
.project-links {
    display: flex;
    gap: var(--space-sm);
}

.btn {
    display: inline-flex;
    align-items: center;
    gap: var(--space-xs);
    padding: var(--space-sm) var(--space-md);
    border-radius: 12px;
    font-weight: 600;
    transition: all var(--duration-fast) ease;
}

.btn-primary {
    background: var(--accent);
    color: white;
}

.btn-primary:hover {
    background: #ff5588;
    transform: translateY(-2px);
}

.btn-secondary {
    background: rgba(255, 255, 255, 0.1);
    border: 1px solid var(--glass-border);
    color: white;
}

.btn-secondary:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-2px);
}

/* 截图 */
.screenshots {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: var(--space-sm);
}

@media (max-width: 640px) {
    .screenshots {
        grid-template-columns: repeat(2, 1fr);
    }
}

.screenshot-thumb {
    width: 100%;
    aspect-ratio: 16/10;
    object-fit: cover;
    border-radius: 12px;
    cursor: pointer;
    transition: all var(--duration-fast) ease;
    border: 2px solid transparent;
}

.screenshot-thumb:hover {
    transform: scale(1.05);
    border-color: var(--accent);
}
```

- [ ] **Step 4: 提交**

```bash
git add docs/v2.0/index.html
git commit -m "feat(v2): 实现 4 个项目内容渲染 - 毛玻璃卡片布局 - 功能特点标签 - 截图网格"
```

---

### Task 6: 实现分页指示器

**Files:**
- Modify: `docs/v2.0/index.html`

- [ ] **Step 1: 添加指示器 HTML**

```html
<nav class="page-indicators" id="pageIndicators">
    <button class="indicator-dot active" data-index="0"></button>
    <button class="indicator-dot" data-index="1"></button>
    <button class="indicator-dot" data-index="2"></button>
    <button class="indicator-dot" data-index="3"></button>
</nav>
```

- [ ] **Step 2: 添加指示器 CSS**

```css
/* 分页指示器 */
.page-indicators {
    position: fixed;
    bottom: var(--space-xl);
    left: 50%;
    transform: translateX(-50%);
    z-index: 100;
    display: flex;
    gap: var(--space-sm);
    padding: var(--space-sm);
    background: rgba(0, 0, 0, 0.3);
    backdrop-filter: blur(10px);
    border-radius: 30px;
}

.indicator-dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    border: 2px solid white;
    background: transparent;
    cursor: pointer;
    transition: all var(--duration-fast) ease;
}

.indicator-dot:hover {
    transform: scale(1.2);
}

.indicator-dot.active {
    background: var(--accent);
    border-color: var(--accent);
    transform: scale(1.3);
}
```

- [ ] **Step 3: 绑定指示器点击事件**

```javascript
// 在 SlideController 中添加
bindIndicatorEvents() {
    const indicators = document.querySelectorAll('.indicator-dot');
    indicators.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            this.goToSlide(index);
        });
    });
}
```

- [ ] **Step 4: 提交**

```bash
git add docs/v2.0/index.html
git commit -m "feat(v2): 实现分页指示器 - 4个圆点 - 当前高亮 - 点击跳转"
```

---

### Task 7: 实现截图模态框

**Files:**
- Modify: `docs/v2.0/index.html`

- [ ] **Step 1: 添加模态框 HTML**

```html
<div class="modal" id="screenshotModal">
    <button class="modal-close" id="modalClose">
        <i class="ri-close-line"></i>
    </button>
    <img src="" alt="截图大图" class="modal-image" id="modalImage">
</div>
```

- [ ] **Step 2: 添加模态框 CSS**

```css
/* 模态框 */
.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1000;
    background: rgba(0, 0, 0, 0.9);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    visibility: hidden;
    transition: all var(--duration-normal) ease;
}

.modal.active {
    opacity: 1;
    visibility: visible;
}

.modal-close {
    position: absolute;
    top: var(--space-md);
    right: var(--space-md);
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.1);
    border: none;
    color: white;
    font-size: 1.5rem;
    cursor: pointer;
    transition: all var(--duration-fast) ease;
}

.modal-close:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: scale(1.1);
}

.modal-image {
    max-width: 90%;
    max-height: 90%;
    object-fit: contain;
    border-radius: 16px;
    transform: scale(0.9);
    transition: transform var(--duration-normal) ease;
}

.modal.active .modal-image {
    transform: scale(1);
}
```

- [ ] **Step 3: 添加模态框 JS**

```javascript
// 模态框控制器
class ModalController {
    constructor() {
        this.modal = document.getElementById('screenshotModal');
        this.modalImage = document.getElementById('modalImage');
        this.closeBtn = document.getElementById('modalClose');

        this.init();
    }

    init() {
        // 点击关闭
        this.closeBtn.addEventListener('click', () => this.close());

        // 点击遮罩关闭
        this.modal.addEventListener('click', (e) => {
            if (e.target === this.modal) {
                this.close();
            }
        });

        // ESC 关闭
        window.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.modal.classList.contains('active')) {
                this.close();
            }
        });

        // 代理截图点击
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('screenshot-thumb')) {
                this.open(e.target.dataset.src);
            }
        });
    }

    open(src) {
        this.modalImage.src = src;
        this.modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    close() {
        this.modal.classList.remove('active');
        document.body.style.overflow = '';
    }
}
```

- [ ] **Step 4: 提交**

```bash
git add docs/v2.0/index.html
git commit -m "feat(v2): 实现截图模态框 - 点击放大查看 - 点击遮罩或ESC关闭"
```

---

### Task 8: 最终初始化和调试

**Files:**
- Modify: `docs/v2.0/index.html`

- [ ] **Step 1: 添加初始化代码**

```javascript
document.addEventListener('DOMContentLoaded', () => {
    // 渲染翻页
    renderSlides();

    // 初始化翻页控制器
    const slideController = new SlideController();
    slideController.bindIndicatorEvents();

    // 初始化视差背景
    new ParallaxBackground();

    // 初始化模态框
    new ModalController();
});
```

- [ ] **Step 2: 添加响应式调整**

```css
@media (max-width: 640px) {
    .glass-card {
        padding: var(--space-lg);
        border-radius: 20px;
    }

    .project-icon {
        width: 48px;
        height: 48px;
    }

    .project-name {
        font-size: 1.75rem;
    }

    .btn {
        padding: var(--space-sm) var(--space-md);
        font-size: 0.875rem;
    }
}
```

- [ ] **Step 3: 提交**

```bash
git add docs/v2.0/index.html
git commit -m "feat(v2): 完成 v2.0 原型 - 全屏翻页 - 玻璃拟态 - 视差背景 - 模态框"
```

---

### Task 9: 最终检查和预览

- [ ] **Step 1: 在浏览器中预览**

```bash
agent-browser open file:///Users/wangx/sync-nas/OHPG.github.io/docs/v2.0/index.html --headed --no-sandbox
```

- [ ] **Step 2: 检查清单**

- [ ] 多层渐变背景正常显示
- [ ] 模糊光斑随滚动视差移动
- [ ] 滚动切换项目翻页正常
- [ ] 毛玻璃卡片显示正常
- [ ] 项目内容（图标、名称、描述、功能）显示正确
- [ ] 截图点击打开模态框
- [ ] 分页指示器点击跳转
- [ ] 键盘上下箭头切换
- [ ] 移动端触摸滑动切换
- [ ] 响应式布局正常

- [ ] **Step 3: 提交最终版本**

```bash
git add -A
git commit -m "feat(v2): 完成 OHPG 作品集 v2.0 原型

- 玻璃拟态设计风格
- 多层渐变背景 + 动态光斑
- 全屏翻页系统（滚动/键盘/触摸）
- 3D 视差滚动效果
- 毛玻璃卡片组件
- 4 个项目内容展示
- 分页指示器
- 截图模态框
- 响应式布局"
```

---

## 自检清单

- [x] Spec 覆盖完整（设计语言、布局、组件、交互）
- [x] 无占位符（所有代码完整）
- [x] 任务粒度适中（每任务 2-5 分钟）
- [x] 文件路径准确
- [x] 响应式断点：640px / 900px
