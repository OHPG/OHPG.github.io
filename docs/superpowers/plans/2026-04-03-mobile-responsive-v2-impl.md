# 移动端响应式适配实施计划 V2

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 修复移动端布局问题，实现水平滚动应用列表、水平 Meta 信息、Tab 图标等功能

**Architecture:** 使用纯 CSS 媒体查询响应式方案，修改现有样式而非引入新框架

**Tech Stack:** 纯 CSS, 媒体查询, Flexbox

---

## 文件清单

| 文件 | 操作 |
|------|------|
| `assets/css/style.css` | 修改 - 响应式样式调整 |

---

## 实施步骤

### Task 1: Hero 标题防换行

**Files:**
- Modify: `assets/css/style.css` (`.hero-content h1`)

- [ ] **Step 1: 修改 h1 样式添加 white-space: nowrap**

```css
.hero-content h1 {
    font-size: clamp(1.6rem, 5vw, 3.5rem);
    white-space: nowrap;
    margin-bottom: 1.5rem;
    color: var(--text);
    line-height: 1.2;
}
```

- [ ] **Step 2: 验证构建**

```bash
bundle exec jekyll build
```

---

### Task 2: 应用列表改为水平滚动

**Files:**
- Modify: `assets/css/style.css` (`.project-scroll`)

- [ ] **Step 1: 修改 .project-scroll 移动端样式**

将之前的 grid 布局改回 flex 水平滚动：

```css
@media (max-width: 768px) {
    .project-scroll {
        display: flex;
        flex-wrap: nowrap;
        overflow-x: auto;
        gap: 0.75rem;
        padding: 0.5rem 1rem;
        scrollbar-width: none;
        -ms-overflow-style: none;
    }

    .project-scroll::-webkit-scrollbar {
        display: none;
    }
}
```

- [ ] **Step 2: 修改 .project-logo-card 移动端样式**

```css
@media (max-width: 768px) {
    .project-logo-card {
        flex: 0 0 auto;
        width: 80px;
        padding: 0.75rem;
        gap: 0.5rem;
    }
}
```

- [ ] **Step 3: 验证构建**

```bash
bundle exec jekyll build
```

---

### Task 3: 项目 Meta 信息改为水平排列

**Files:**
- Modify: `assets/css/style.css` (`.project-meta`)

- [ ] **Step 1: 修改 .project-meta 移动端样式**

```css
@media (max-width: 768px) {
    .project-meta {
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 1rem;
        flex-wrap: wrap;
        margin-bottom: 1.5rem;
    }

    .meta-item {
        font-size: 0.8rem;
    }
}
```

- [ ] **Step 2: 验证构建**

```bash
bundle exec jekyll build
```

---

### Task 4: Tab 只显示图标

**Files:**
- Modify: `assets/css/style.css` (`.device-tab`)

- [ ] **Step 1: 添加移动端隐藏文字样式**

```css
@media (max-width: 768px) {
    .device-tab span {
        display: none;
    }

    .device-tab {
        padding: 0.8rem;
        min-height: 44px;
        flex: 1;
    }
}
```

- [ ] **Step 2: 验证构建**

```bash
bundle exec jekyll build
```

---

### Task 5: 截图缩小完整显示

**Files:**
- Modify: `assets/css/style.css` (`.preview-images`, `.preview-img`)

- [ ] **Step 1: 修改 .preview-images 移动端样式**

```css
@media (max-width: 768px) {
    .preview-images {
        width: 120px;
        height: auto;
        aspect-ratio: 9/16;
        margin: 0 auto;
        border-radius: 12px;
    }
}
```

- [ ] **Step 2: 修改 .preview-img 移动端样式**

```css
@media (max-width: 768px) {
    .preview-img {
        width: 100%;
        height: auto;
        max-height: none;
    }
}
```

- [ ] **Step 3: 验证构建**

```bash
bundle exec jekyll build
```

---

### Task 6: 指示器样式优化

**Files:**
- Modify: `assets/css/style.css` (`.indicator`)

- [ ] **Step 1: 添加移动端指示器样式**

```css
@media (max-width: 768px) {
    .indicator {
        padding: 0.6rem 0.8rem;
    }

    .indicator h3 {
        font-size: 0.85rem;
    }

    .indicator p {
        font-size: 0.75rem;
    }
}
```

- [ ] **Step 2: 验证构建**

```bash
bundle exec jekyll build
```

---

### Task 7: 最终验证

- [ ] **Step 1: 构建验证**

```bash
bundle exec jekyll build
```

- [ ] **Step 2: 浏览器测试**

```bash
npx agent-browser open http://127.0.0.1:4000
npx agent-browser set device "iPhone 12"
npx agent-browser screenshot /Users/wangx/sync-nas/OHPG.github.io/v2-mobile-1.png
npx agent-browser scroll down 600
npx agent-browser screenshot /Users/wangx/sync-nas/OHPG.github.io/v2-mobile-2.png
npx agent-browser scroll down 800
npx agent-browser screenshot /Users/wangx/sync-nas/OHPG.github.io/v2-mobile-3.png
npx agent-browser close
```

- [ ] **Step 3: 检查关键元素**

移动端验证清单：
- [ ] Hero 标题同一行显示
- [ ] 应用列表水平滚动
- [ ] Meta 信息水平排列
- [ ] Tab 只显示图标
- [ ] 截图完整显示

---

## 预期结果

### 移动端 (<768px)
- Hero 标题 "创新技术 优质体验" 同一行
- 应用列表水平滚动
- Meta 信息水平排列
- Tab 只有图标
- 截图按比例缩小完整显示

### PC 端 (>1024px)
- 保持原有布局不变
