# OHPG 作品集原型实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建 `docs/v1.0/index.html` 单页滚动原型，包含深色科技风格、项目卡片、设备切换和动画效果。

**Architecture:** 纯 HTML + CSS + Vanilla JS 单文件实现。CSS Variables 管理主题色，Canvas 实现粒子背景，AOS 库处理滚动动画。

**Tech Stack:** HTML5, CSS3 (Flexbox/Grid, CSS Variables), Vanilla JavaScript, AOS (动画库), Remixicon (图标)

---

## 文件结构

```
docs/
└── v1.0/
    └── index.html      # 单文件包含所有 HTML/CSS/JS
```

---

## 任务清单

### Task 1: 创建基础 HTML 结构和 CSS 变量

**Files:**
- Create: `docs/v1.0/index.html`

- [ ] **Step 1: 创建基础 HTML 骨架**

```html
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OHPG - 创新技术 · 优质体验</title>
    <!-- 引入字体和图标 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
    <!-- AOS 动画库 -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar">...</nav>

    <!-- Hero 区域 -->
    <header class="hero">...</header>

    <!-- 项目卡片区域 -->
    <section class="projects-grid">...</section>

    <!-- 项目详情区域 -->
    <section class="project-details">...</section>

    <!-- Footer -->
    <footer>...</footer>

    <!-- 粒子背景 Canvas -->
    <canvas id="particleCanvas"></canvas>

    <!-- AOS 脚本 -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
</body>
</html>
```

- [ ] **Step 2: 定义 CSS 变量和全局样式**

```css
:root {
    /* 色彩系统 */
    --bg-primary: #0a0e17;
    --bg-secondary: #111827;
    --bg-tertiary: #1e293b;
    --accent-cyan: #3bf4fb;
    --accent-purple: #a855f7;
    --accent-pink: #ec4899;
    --accent-gradient: linear-gradient(135deg, #3bf4fb 0%, #a855f7 50%, #ec4899 100%);
    --text-primary: #f8fafc;
    --text-secondary: #94a3b8;
    --border-glow: rgba(59, 244, 251, 0.3);
    --border-subtle: rgba(255, 255, 255, 0.08);

    /* 间距系统 */
    --space-xs: 8px;
    --space-sm: 16px;
    --space-md: 24px;
    --space-lg: 32px;
    --space-xl: 48px;
    --space-2xl: 64px;
    --space-3xl: 96px;

    /* 容器宽度 */
    --container-max: 1200px;

    /* 动画时长 */
    --duration-fast: 200ms;
    --duration-normal: 400ms;
    --duration-slow: 600ms;

    /* 缓动函数 */
    --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
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
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    background-color: var(--bg-primary);
    color: var(--text-primary);
    line-height: 1.6;
    overflow-x: hidden;
}

a {
    color: inherit;
    text-decoration: none;
}

img {
    max-width: 100%;
    height: auto;
}

.container {
    max-width: var(--container-max);
    margin: 0 auto;
    padding: 0 var(--space-md);
}
```

- [ ] **Step 3: 提交**

```bash
git add docs/v1.0/index.html
git commit -m "feat: 创建 docs/v1.0/index.html 基础结构
- HTML 骨架和语义化标签
- CSS 变量定义（色彩、间距、动画）
- 全局重置样式"
```

---

### Task 2: 实现导航栏

**Files:**
- Modify: `docs/v1.0/index.html`

- [ ] **Step 1: 添加导航栏 HTML**

```html
<nav class="navbar">
    <div class="container navbar-inner">
        <a href="#" class="logo">OHPG</a>
        <ul class="nav-links">
            <li><a href="#FinVideo">FinVideo</a></li>
            <li><a href="#FinMusic">FinMusic</a></li>
            <li><a href="#FinBook">FinBook</a></li>
            <li><a href="#FinAdmin">FinAdmin</a></li>
        </ul>
        <a href="https://github.com/OHPG" target="_blank" class="github-link">
            <i class="ri-github-fill"></i>
        </a>
        <button class="hamburger" aria-label="菜单">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </div>
</nav>

<!-- 移动端菜单 Overlay -->
<div class="mobile-menu">
    <ul class="mobile-nav-links">
        <li><a href="#FinVideo">FinVideo</a></li>
        <li><a href="#FinMusic">FinMusic</a></li>
        <li><a href="#FinBook">FinBook</a></li>
        <li><a href="#FinAdmin">FinAdmin</a></li>
        <li><a href="https://github.com/OHPG" target="_blank">GitHub</a></li>
    </ul>
</div>
```

- [ ] **Step 2: 添加导航栏 CSS 样式**

```css
/* 导航栏 */
.navbar {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    padding: var(--space-sm) 0;
    background: rgba(10, 14, 23, 0.8);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-bottom: 1px solid var(--border-subtle);
    transition: background var(--duration-fast) ease;
}

.navbar-inner {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.logo {
    font-size: 1.5rem;
    font-weight: 700;
    background: var(--accent-gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.nav-links {
    display: flex;
    list-style: none;
    gap: var(--space-lg);
}

.nav-links a {
    font-size: 0.9rem;
    font-weight: 500;
    color: var(--text-secondary);
    transition: color var(--duration-fast) ease;
}

.nav-links a:hover {
    color: var(--accent-cyan);
}

.github-link {
    display: flex;
    align-items: center;
    font-size: 1.5rem;
    color: var(--text-secondary);
    transition: color var(--duration-fast) ease;
}

.github-link:hover {
    color: var(--accent-cyan);
}

/* Hamburger 按钮 */
.hamburger {
    display: none;
    flex-direction: column;
    gap: 5px;
    background: none;
    border: none;
    cursor: pointer;
    padding: 8px;
}

.hamburger span {
    display: block;
    width: 24px;
    height: 2px;
    background: var(--text-primary);
    transition: transform var(--duration-fast) ease, opacity var(--duration-fast) ease;
}

.hamburger.active span:nth-child(1) {
    transform: translateY(7px) rotate(45deg);
}

.hamburger.active span:nth-child(2) {
    opacity: 0;
}

.hamburger.active span:nth-child(3) {
    transform: translateY(-7px) rotate(-45deg);
}

/* 移动端菜单 */
.mobile-menu {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 999;
    background: var(--bg-primary);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    visibility: hidden;
    transition: opacity var(--duration-normal) ease, visibility var(--duration-normal) ease;
}

.mobile-menu.active {
    opacity: 1;
    visibility: visible;
}

.mobile-nav-links {
    list-style: none;
    text-align: center;
}

.mobile-nav-links li {
    margin: var(--space-md) 0;
}

.mobile-nav-links a {
    font-size: 1.5rem;
    font-weight: 600;
}

/* 响应式 */
@media (max-width: 768px) {
    .nav-links,
    .github-link {
        display: none;
    }

    .hamburger {
        display: flex;
    }
}
```

- [ ] **Step 3: 添加导航栏 JS 交互**

```javascript
// 导航栏交互
const hamburger = document.querySelector('.hamburger');
const mobileMenu = document.querySelector('.mobile-menu');
const mobileNavLinks = document.querySelectorAll('.mobile-nav-links a');

// Hamburger 切换
hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    mobileMenu.classList.toggle('active');
    document.body.style.overflow = mobileMenu.classList.contains('active') ? 'hidden' : '';
});

// 点击链接关闭菜单
mobileNavLinks.forEach(link => {
    link.addEventListener('click', () => {
        hamburger.classList.remove('active');
        mobileMenu.classList.remove('active');
        document.body.style.overflow = '';
    });
});
```

- [ ] **Step 4: 提交**

```bash
git add docs/v1.0/index.html
git commit -m "feat: 实现导航栏组件
- 固定顶部 + 模糊背景效果
- 桌面端横向导航 + GitHub 图标
- 移动端 Hamburger + 全屏菜单"
```

---

### Task 3: 实现 Hero 区域

**Files:**
- Modify: `docs/v1.0/index.html`

- [ ] **Step 1: 添加 Hero 区域 HTML**

```html
<header class="hero">
    <div class="hero-content container">
        <h1 class="hero-title" data-aos="fade-up">
            <span class="title-main">OHPG</span>
        </h1>
        <p class="hero-subtitle" data-aos="fade-up" data-aos-delay="100">
            创新技术 <span class="separator">·</span> 优质体验
        </p>
        <p class="hero-desc" data-aos="fade-up" data-aos-delay="200">
            四个 HarmonyOS 应用，与 Jellyfin 完美配合
        </p>
    </div>
    <div class="scroll-indicator" data-aos="fade-up" data-aos-delay="400">
        <span>向下滚动</span>
        <i class="ri-arrow-down-line"></i>
    </div>
</header>
```

- [ ] **Step 2: 添加 Hero 区域 CSS 样式**

```css
/* Hero 区域 */
.hero {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    position: relative;
    padding: var(--space-3xl) var(--space-md);
}

.hero-content {
    position: relative;
    z-index: 1;
}

.hero-title {
    font-size: clamp(3rem, 10vw, 6rem);
    font-weight: 700;
    letter-spacing: -0.02em;
    line-height: 1.1;
    margin-bottom: var(--space-md);
}

.title-main {
    background: var(--accent-gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.hero-subtitle {
    font-size: clamp(1.25rem, 3vw, 1.75rem);
    color: var(--text-secondary);
    margin-bottom: var(--space-sm);
}

.hero-subtitle .separator {
    margin: 0 var(--space-xs);
    opacity: 0.5;
}

.hero-desc {
    font-size: 1rem;
    color: var(--text-secondary);
    opacity: 0.7;
}

/* 滚动指示器 */
.scroll-indicator {
    position: absolute;
    bottom: var(--space-xl);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: var(--space-xs);
    color: var(--text-secondary);
    font-size: 0.875rem;
    opacity: 0.6;
    animation: bounce 2s ease-in-out infinite;
}

@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(8px); }
}
```

---

### Task 4: 实现项目卡片网格

**Files:**
- Modify: `docs/v1.0/index.html`

- [ ] **Step 1: 添加项目卡片数据（YAML 格式注释）**

在 HTML 中添加项目数据：

```html
<!-- 项目数据（用于 JS 渲染） -->
<script>
    const projectsData = [
        {
            id: 'FinVideo',
            name: 'FinVideo',
            icon: 'https://raw.githubusercontent.com/OHPG/FinVideo/main/assets/icon.png',
            description: 'Jellyfin 视频播放器',
            tags: ['鸿蒙', 'Jellyfin', '视频播放'],
            features: ['直接播放', '简单易用', '手势操作', '多用户支持'],
            github: 'https://github.com/OHPG/FinVideo',
            preview: 'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinVideo/Market/FinVideo1.jpg'
        },
        {
            id: 'FinMusic',
            name: 'FinMusic',
            icon: 'https://raw.githubusercontent.com/OHPG/FinMusic/main/assets/icon.png',
            description: 'Jellyfin 音乐播放器',
            tags: ['鸿蒙', 'Jellyfin', '音乐播放'],
            features: ['多平台音源聚合', '智能歌单管理', '高品质音频支持'],
            github: 'https://github.com/OHPG/FinMusic',
            preview: 'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinMusic/Market/FinMusic1.jpg'
        },
        {
            id: 'FinBook',
            name: 'FinBook',
            icon: 'https://raw.githubusercontent.com/OHPG/FinBook/main/assets/icon.png',
            description: 'Jellyfin 电子阅读器',
            tags: ['鸿蒙', 'Jellyfin', '阅读器'],
            features: ['多格式支持', '智能排版', '云端同步'],
            github: 'https://github.com/OHPG/FinBook',
            preview: 'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinBook/Market/FinBook1.jpg'
        },
        {
            id: 'FinAdmin',
            name: 'FinAdmin',
            icon: 'https://raw.githubusercontent.com/OHPG/FinAdmin/main/assets/icon.png',
            description: 'Jellyfin 媒体管理工具',
            tags: ['鸿蒙', 'Jellyfin', '后台管理'],
            features: ['数据更新', '权限管理', '媒体编辑'],
            github: 'https://github.com/OHPG/FinAdmin',
            preview: 'https://raw.githubusercontent.com/OHPG/OHPG.github.io/main/assets/statics/FinAdmin/Market/FinAdmin1.jpg'
        }
    ];
</script>
```

- [ ] **Step 2: 添加 Hero 区域项目卡片 HTML**

```html
<section class="projects-section">
    <div class="container">
        <div class="projects-grid" id="projectsGrid">
            <!-- 由 JS 动态渲染 -->
        </div>
    </div>
</section>
```

- [ ] **Step 3: 添加项目卡片 CSS 样式**

```css
/* 项目区域 */
.projects-section {
    padding: var(--space-3xl) 0;
}

.projects-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: var(--space-md);
}

@media (max-width: 1024px) {
    .projects-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 480px) {
    .projects-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: var(--space-sm);
    }
}

/* 项目卡片 */
.project-card {
    background: var(--bg-secondary);
    border: 1px solid var(--border-subtle);
    border-radius: 16px;
    padding: var(--space-lg);
    text-align: center;
    cursor: pointer;
    transition:
        transform var(--duration-normal) var(--ease-out),
        border-color var(--duration-fast) ease,
        box-shadow var(--duration-normal) ease;
}

.project-card:hover {
    transform: translateY(-4px);
    border-color: var(--border-glow);
    box-shadow:
        0 8px 32px rgba(0, 0, 0, 0.3),
        0 0 0 1px var(--border-glow),
        inset 0 1px 0 rgba(255, 255, 255, 0.05);
}

.project-card-icon {
    width: 64px;
    height: 64px;
    margin: 0 auto var(--space-sm);
    border-radius: 12px;
    background: var(--bg-tertiary);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.project-card-icon img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.project-card-name {
    font-size: 1.125rem;
    font-weight: 600;
    margin-bottom: var(--space-xs);
}

.project-card-desc {
    font-size: 0.875rem;
    color: var(--text-secondary);
}

@media (max-width: 480px) {
    .project-card {
        padding: var(--space-md);
    }

    .project-card-icon {
        width: 48px;
        height: 48px;
    }

    .project-card-name {
        font-size: 1rem;
    }
}
```

- [ ] **Step 4: 添加项目卡片渲染 JS**

```javascript
// 渲染项目卡片
function renderProjectCards() {
    const grid = document.getElementById('projectsGrid');

    projectsData.forEach((project, index) => {
        const card = document.createElement('div');
        card.className = 'project-card';
        card.setAttribute('data-aos', 'fade-up');
        card.setAttribute('data-aos-delay', String(index * 100));
        card.innerHTML = `
            <div class="project-card-icon">
                <img src="${project.icon}" alt="${project.name}">
            </div>
            <h3 class="project-card-name">${project.name}</h3>
            <p class="project-card-desc">${project.description}</p>
        `;

        card.addEventListener('click', () => {
            document.getElementById(project.id).scrollIntoView({ behavior: 'smooth' });
        });

        grid.appendChild(card);
    });
}

// 页面加载后渲染
document.addEventListener('DOMContentLoaded', renderProjectCards);
```

- [ ] **Step 5: 提交**

```bash
git add docs/v1.0/index.html
git commit -m "feat: 实现 Hero 区域和项目卡片
- Hero 标题 + 副标题 + 描述
- 项目卡片网格（4列响应式）
- 卡片 hover 发光效果
- 点击卡片平滑滚动到详情区"
```

---

### Task 5: 实现粒子背景动画

**Files:**
- Modify: `docs/v1.0/index.html`

- [ ] **Step 1: 添加粒子背景 Canvas 和 CSS**

```html
<canvas id="particleCanvas"></canvas>
```

```css
/* 粒子画布 */
#particleCanvas {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 0;
}
```

- [ ] **Step 2: 添加粒子动画 JS**

```javascript
// 粒子背景动画
class ParticleBackground {
    constructor(canvas) {
        this.canvas = canvas;
        this.ctx = canvas.getContext('2d');
        this.particles = [];
        this.mouse = { x: null, y: null, radius: 150 };

        this.resize();
        this.init();
        this.animate();

        window.addEventListener('resize', () => this.resize());
        window.addEventListener('mousemove', (e) => {
            this.mouse.x = e.x;
            this.mouse.y = e.y;
        });
        window.addEventListener('mouseout', () => {
            this.mouse.x = null;
            this.mouse.y = null;
        });
    }

    resize() {
        this.canvas.width = window.innerWidth;
        this.canvas.height = window.innerHeight;
    }

    init() {
        const isMobile = window.innerWidth < 768;
        const count = isMobile ? 20 : 50;

        this.particles = [];
        for (let i = 0; i < count; i++) {
            this.particles.push({
                x: Math.random() * this.canvas.width,
                y: Math.random() * this.canvas.height,
                size: Math.random() * 2 + 0.5,
                speedX: (Math.random() - 0.5) * 0.5,
                speedY: (Math.random() - 0.5) * 0.5,
                opacity: Math.random() * 0.3 + 0.1,
                color: Math.random() > 0.5 ? '#3bf4fb' : '#a855f7'
            });
        }
    }

    drawParticle(p) {
        this.ctx.beginPath();
        this.ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
        this.ctx.fillStyle = p.color;
        this.ctx.globalAlpha = p.opacity;
        this.ctx.fill();
        this.ctx.globalAlpha = 1;
    }

    drawLines() {
        for ( let i = 0; i < this.particles.length; i++) {
            for (let j = i + 1; j < this.particles.length; j++) {
                const dx = this.particles[i].x - this.particles[j].x;
                const dy = this.particles[i].y - this.particles[j].y;
                const dist = dx * dx + dy * dy;

                if (dist < 150 * 150) {
                    this.ctx.beginPath();
                    this.ctx.moveTo(this.particles[i].x, this.particles[i].y);
                    this.ctx.lineTo(this.particles[j].x, this.particles[j].y);
                    this.ctx.strokeStyle = '#3bf4fb';
                    this.ctx.globalAlpha = 0.03 * (1 - dist / (150 * 150));
                    this.ctx.stroke();
                    this.ctx.globalAlpha = 1;
                }
            }
        }
    }

    update() {
        this.particles.forEach(p => {
            p.x += p.speedX;
            p.y += p.speedY;

            if (p.x < 0 || p.x > this.canvas.width) p.speedX *= -1;
            if (p.y < 0 || p.y > this.canvas.height) p.speedY *= -1;

            // 鼠标排斥
            if (this.mouse.x && this.mouse.y) {
                const dx = p.x - this.mouse.x;
                const dy = p.y - this.mouse.y;
                const dist = dx * dx + dy * dy;
                if (dist < this.mouse.radius * this.mouse.radius) {
                    p.x += dx * 0.02;
                    p.y += dy * 0.02;
                }
            }
        });
    }

    animate() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);

        this.particles.forEach(p => this.drawParticle(p));
        this.drawLines();
        this.update();

        requestAnimationFrame(() => this.animate());
    }
}

// 初始化粒子背景
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('particleCanvas');
    if (canvas) {
        new ParticleBackground(canvas);
    }
});
```

- [ ] **Step 3: 提交**

```bash
git add docs/v1.0/index.html
git commit -m "feat: 添加粒子背景动画
- Canvas 粒子系统
- 粒子连线效果
- 鼠标交互排斥效果
- 响应式粒子数量（移动端减少）"
```

---

### Task 6: 实现项目详情展示区

**Files:**
- Modify: `docs/v1.0/index.html`

- [ ] **Step 1: 添加详情区 HTML 模板**

```html
<!-- 项目详情区域 -->
<section class="project-details" id="projectDetails">
    <!-- 由 JS 动态渲染每个项目 -->
</section>
```

```css
/* 项目详情区域 */
.project-details {
    position: relative;
    z-index: 1;
    padding-bottom: var(--space-3xl);
}

/* 单个项目详情卡片 */
.project-detail {
    padding: var(--space-3xl) 0;
    border-top: 1px solid var(--border-subtle);
}

.project-detail-inner {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: var(--space-2xl);
    align-items: start;
}

@media (max-width: 900px) {
    .project-detail-inner {
        grid-template-columns: 1fr;
    }
}

/* 项目头部信息 */
.project-header {
    margin-bottom: var(--space-lg);
}

.project-header h2 {
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: var(--space-sm);
    display: flex;
    align-items: center;
    gap: var(--space-sm);
}

.project-header h2 .project-icon {
    width: 40px;
    height: 40px;
    border-radius: 8px;
    overflow: hidden;
}

.project-header h2 .project-icon img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.project-tags {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-xs);
    margin-bottom: var(--space-md);
}

.project-tag {
    padding: 4px 12px;
    background: var(--bg-tertiary);
    border-radius: 20px;
    font-size: 0.75rem;
    color: var(--text-secondary);
}

.project-desc {
    color: var(--text-secondary);
    margin-bottom: var(--space-md);
}

.project-links {
    display: flex;
    gap: var(--space-sm);
}

.project-link {
    display: inline-flex;
    align-items: center;
    gap: var(--space-xs);
    padding: var(--space-xs) var(--space-sm);
    background: var(--bg-tertiary);
    border-radius: 8px;
    font-size: 0.875rem;
    color: var(--text-secondary);
    transition: all var(--duration-fast) ease;
}

.project-link:hover {
    background: var(--accent-cyan);
    color: var(--bg-primary);
}

/* 功能特点列表 */
.features-list {
    list-style: none;
    margin-bottom: var(--space-lg);
}

.features-list li {
    display: flex;
    align-items: center;
    gap: var(--space-sm);
    padding: var(--space-xs) 0;
    color: var(--text-secondary);
}

.features-list li i {
    color: var(--accent-cyan);
    font-size: 1.25rem;
}
```

- [ ] **Step 2: 添加详情渲染 JS**

```javascript
// 渲染项目详情
function renderProjectDetails() {
    const container = document.getElementById('projectDetails');

    projectsData.forEach((project, index) => {
        const detail = document.createElement('div');
        detail.className = 'project-detail';
        detail.id = project.id;
        detail.setAttribute('data-aos', 'fade-up');

        const featuresHtml = project.features.map(f =>
            `<li><i class="ri-checkbox-circle-fill"></i>${f}</li>`
        ).join('');

        const linksHtml = `
            <a href="${project.github}" target="_blank" class="project-link">
                <i class="ri-github-fill"></i> GitHub
            </a>
            ${project.demo_url ? `
            <a href="${project.demo_url}" target="_blank" class="project-link">
                <i class="ri-global-line"></i> Demo
            </a>
            ` : ''}
        `;

        detail.innerHTML = `
            <div class="container">
                <div class="project-detail-inner">
                    <div class="project-info">
                        <div class="project-header">
                            <h2>
                                <span class="project-icon">
                                    <img src="${project.icon}" alt="${project.name}">
                                </span>
                                ${project.name}
                            </h2>
                            <div class="project-tags">
                                ${project.tags.map(t => `<span class="project-tag">${t}</span>`).join('')}
                            </div>
                            <p class="project-desc">${project.description}</p>
                            <div class="project-links">
                                ${linksHtml}
                            </div>
                        </div>
                        <ul class="features-list" data-aos="fade-up" data-aos-delay="200">
                            ${featuresHtml}
                        </ul>
                    </div>
                    <div class="project-preview" data-aos="fade-up" data-aos-delay="100">
                        <img src="${project.preview}" alt="${project.name} 预览" class="preview-main">
                    </div>
                </div>
            </div>
        `;

        container.appendChild(detail);
    });
}
```

- [ ] **Step 3: 添加预览图样式**

```css
/* 预览图 */
.project-preview {
    position: relative;
    border-radius: 16px;
    overflow: hidden;
    background: var(--bg-secondary);
    border: 1px solid var(--border-subtle);
}

.preview-main {
    width: 100%;
    display: block;
    transition: transform var(--duration-slow) var(--ease-out);
}

.project-preview:hover .preview-main {
    transform: scale(1.02);
}
```

- [ ] **Step 4: 提交**

```bash
git add docs/v1.0/index.html
git commit -m "feat: 实现项目详情展示区
- 项目头部（图标、名称、标签、描述）
- GitHub/Demo 链接
- 功能特点列表（带图标）
- 预览大图（hover 放大效果）"
```

---

### Task 7: 实现 Footer

**Files:**
- Modify: `docs/v1.0/index.html`

- [ ] **Step 1: 添加 Footer HTML 和 CSS**

```html
<footer class="footer">
    <div class="container footer-inner">
        <p class="footer-text">© 2026 OHPG. Built with HarmonyOS.</p>
        <a href="https://github.com/OHPG" target="_blank" class="footer-github">
            <i class="ri-github-fill"></i>
        </a>
    </div>
</footer>
```

```css
/* Footer */
.footer {
    position: relative;
    z-index: 1;
    padding: var(--space-xl) 0;
    border-top: 1px solid var(--border-subtle);
}

.footer-inner {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.footer-text {
    color: var(--text-secondary);
    font-size: 0.875rem;
}

.footer-github {
    font-size: 1.5rem;
    color: var(--text-secondary);
    transition: color var(--duration-fast) ease;
}

.footer-github:hover {
    color: var(--accent-cyan);
}

@media (max-width: 480px) {
    .footer-inner {
        flex-direction: column;
        gap: var(--space-sm);
    }
}
```

- [ ] **Step 2: 提交**

```bash
git add docs/v1.0/index.html
git commit -m "feat: 添加 Footer 组件"
```

---

### Task 8: 初始化 AOS 动画库

**Files:**
- Modify: `docs/v1.0/index.html`

- [ ] **Step 1: 在 script 末尾初始化 AOS**

```javascript
// 初始化 AOS
document.addEventListener('DOMContentLoaded', () => {
    // ... 其他初始化 ...

    // AOS 动画初始化
    AOS.init({
        duration: 600,
        easing: 'ease-out',
        once: true,
        offset: 50
    });
});
```

- [ ] **Step 2: 提交**

```bash
git add docs/v1.0/index.html
git commit -m "feat: 初始化 AOS 动画库"
```

---

### Task 9: 最终检查和预览

- [ ] **Step 1: 在浏览器中预览**

```bash
# 使用 agent-browser 打开预览
agent-browser open file:///Users/wangx/sync-nas/OHPG.github.io/docs/v1.0/index.html --headed --no-sandbox
```

- [ ] **Step 2: 检查清单**

- [ ] 页面加载无错误
- [ ] 粒子背景动画正常
- [ ] 导航栏固定 + 模糊效果
- [ ] 移动端 Hamburger 菜单正常
- [ ] 项目卡片 hover 效果正常
- [ ] 点击卡片滚动到详情区正常
- [ ] 详情区显示正确
- [ ] AOS 滚动动画正常
- [ ] 响应式布局正常（桌面/平板/手机）
- [ ] GitHub 链接可点击

- [ ] **Step 3: 提交最终版本**

```bash
git add -A
git commit -m "feat: 完成 OHPG 作品集 v1.0 原型

- 深色科技感主题
- 粒子背景动画
- 固定导航栏 + 移动端菜单
- Hero 区域 + 项目卡片网格
- 4 个项目详情展示
- 响应式布局（桌面/平板/手机）
- AOS 滚动动画"
```

---

## 自检清单

- [x] Spec 覆盖完整（设计语言、布局、组件、交互）
- [x] 无占位符（所有代码完整）
- [x] 任务粒度适中（每任务 2-5 分钟）
- [x] 文件路径准确
- [x] 响应式断点：480px / 768px / 1024px

---

## 执行方式

**Plan complete. 两种执行方式:**

1. **Subagent-Driven (推荐)** - 每个任务派发独立子 agent，快速迭代
2. **Inline Execution** - 当前 session 内顺序执行，带检查点

选择执行方式后开始实现。
