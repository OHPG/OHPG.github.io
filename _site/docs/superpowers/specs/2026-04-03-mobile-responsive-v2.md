# 移动端响应式适配设计方案 V2

> **Goal:** 修复当前移动端布局问题，实现符合移动端交互标准的展示效果

## 设计决策

| 问题 | 解决方案 |
|------|----------|
| Hero 标题换行 | 保持一行，使用 `white-space: nowrap` 和响应式字体 |
| 应用列表显示 | 水平滚动 1 行展示（恢复类似 PC 端） |
| Meta 信息过早换行 | 改为水平排列（同一行） |
| Tab 字体排列 | 只保留 Icon，隐藏文字 |
| 截图显示不全 | 缩小但完整显示，保持比例 |
| 指示器不符合规范 | 重新设计移动端样式 |

---

## 详细设计

### 1. Hero 区域

**标题 (h1):**
- 保持 `clamp()` 响应式字体
- 添加 `white-space: nowrap` 防止换行
- 如果仍溢出自适应缩小字体

```css
.hero-content h1 {
    font-size: clamp(1.6rem, 5vw, 3.5rem);
    white-space: nowrap;
    /* 其他样式保持 */
}
```

**副标题:**
- 使用 `clamp()` 确保不溢出

### 2. 应用列表 (Project Logo)

**移动端布局:**
- 恢复水平滚动（类似 PC 端）
- 每个卡片保持固定宽度

```css
@media (max-width: 768px) {
    .project-scroll {
        display: flex;
        flex-wrap: nowrap;
        overflow-x: auto;
        gap: 0.75rem;
        padding: 0.5rem 1rem;
        scrollbar-width: none;
    }

    .project-logo-card {
        flex: 0 0 auto;
        width: 80px;
    }

    .project-logo {
        width: 48px;
        height: 48px;
    }
}
```

### 3. 项目 Meta 信息

**移动端布局:**
- 改为水平排列
- 减小间距

```css
@media (max-width: 768px) {
    .project-meta {
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 1rem;
        flex-wrap: wrap;
    }

    .meta-item {
        font-size: 0.8rem;
    }
}
```

### 4. 设备 Tab

**移动端:**
- 只显示 Icon
- 隐藏文字

```css
@media (max-width: 768px) {
    .device-tab span {
        display: none;
    }

    .device-tab {
        padding: 0.8rem;
        min-height: 44px;
    }
}
```

### 5. 截图和指示器

**移动端截图:**
- 按比例缩小但完整显示
- 最大宽度不超过屏幕宽度

```css
@media (max-width: 768px) {
    .preview-images {
        width: 120px;
        height: auto;
        aspect-ratio: 9/16;
        margin: 0 auto;
    }

    .preview-img {
        width: 100%;
        height: auto;
        max-height: none;
    }
}
```

**指示器优化:**
- 文字大小适中
- 间距调整

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

---

## 预期效果

### 移动端 (<768px)

**Hero 区域:**
- 标题 "创新技术 优质体验" 同一行显示
- 副标题正常显示
- 应用列表水平滚动

**Projects 区域:**
- 项目标题居中
- Meta 信息水平排列
- Tab 只显示图标
- 截图完整显示

### PC 端 (>1024px)
- 保持原有布局不变
