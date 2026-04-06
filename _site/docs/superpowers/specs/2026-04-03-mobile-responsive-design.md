# 移动端响应式适配设计方案

> **Goal:** 实现 PC 端和移动端双端适配，核心内容完整展示，次要元素简化

## 设计思路

**核心内容完整展示：**
- Hero 标题、副标题 - 保持
- Summary Stats 统计数据 - 保持，改为 2x2 网格
- Projects 区域 - 完整展示

**次要元素简化：**
- 项目 Logo 水平滚动 - 改为 2x2 网格
- GitHub Corner - 缩小尺寸
- 某些装饰效果 - 移动端禁用

## 响应式断点

| 断点 | 设备类型 | 描述 |
|------|----------|------|
| < 480px | 手机 | 最小屏幕 |
| 480-768px | 大手机/小平板 | 过渡尺寸 |
| 768-1024px | 平板/小桌面 | 平板尺寸 |
| > 1024px | 标准桌面 | PC 端 |

## CSS 变量

在 `:root` 中定义：

```css
:root {
    /* 现有变量 */
    --primary: #3bf4fb;
    --secondary: #32ffa5;
    --text: #e2e8f0;
    --bg: #000000;
    --card-bg: rgba(255, 255, 255, 0.05);
    --dark-card: rgba(0, 0, 0, 0.3);
    --gradient: linear-gradient(90deg, var(--primary) 0%, var(--secondary) 100%);

    /* 新增 */
    --max-width: 1200px;
}
```

## 各区域适配方案

### 1. Body 和 Container

| 属性 | PC 端 | 移动端 (<768px) |
|------|-------|-----------------|
| body margin | 2rem | 0 |
| container padding | 2rem | 1rem |

### 2. Hero 区域

| 属性 | PC 端 | 移动端 (<768px) |
|------|-------|-----------------|
| display | flex | block |
| align-items | center | unset |
| min-height | 88vh | auto |
| padding | 2rem 0 | 4rem 0 3rem |
| .logo size | 10rem | 4rem |
| h1 size | 3.5rem | 1.8rem |
| subtitle size | 1.25rem | 0.9rem |

### 3. Summary Stats

| 属性 | PC 端 | 移动端 (<480px) |
|------|-------|-----------------|
| layout | flex 水平 | grid 2x2 |
| gap | 3rem | 0.5rem |
| stat-value size | 2.5rem | 1.5rem |

### 4. Project Logo 列表

| 属性 | PC 端 | 移动端 (<768px) |
|------|-------|-----------------|
| layout | flex 水平滚动 | grid 2x2 |
| card width | 100px | 90px |
| logo size | 64px | 48px |
| padding | 1.5rem | 1rem |

### 5. Projects 区域

| 属性 | PC 端 | 移动端 (<768px) |
|------|-------|-----------------|
| project-title size | 3.5rem | 2rem |
| project-meta | flex | block (垂直) |
| tag size | 0.9rem | 0.75rem |

### 6. Device Preview

| 属性 | PC 端 | 移动端 (<768px) |
|------|-------|-----------------|
| layout | grid 2列 | block 单列 |
| preview-images | 300x600px | 160x320px |
| gap | 4rem | 1.5rem |
| indicators::before | 显示 | 隐藏 |

### 7. GitHub Corner

| 属性 | PC 端 | 移动端 (<768px) |
|------|-------|-----------------|
| svg size | 80x80px | 50x50px |
| octo-arm animation | 启用 | 禁用 |

## 禁用移动端效果

以下效果在移动端 (<768px) 禁用：

1. `.preview-images:hover` 3D 变换效果
2. `.project-logo-card:hover` 上浮效果
3. `.indicator::before` 连接线

## 预期效果

### 移动端 (<480px)
- Hero 区域：Logo 居中 (4rem)，标题 1.8rem，副标题 0.9rem
- Summary Stats：2x2 网格，每个 stat 居中显示
- Project Logo：2x2 网格，4个项目正好一行
- Projects：标题居中，meta 垂直排列，设备预览单列

### PC 端 (>1024px)
- 保持现有布局不变
- Logo 10rem，标题 3.5rem
- Summary Stats 4列水平
- Project Logo 水平滚动
- Device Preview 双列显示

## 文件清单

- `assets/css/style.css` - 修改响应式样式
- `index.md` - 可能需要小幅调整 HTML 结构

## 不引入的依赖

- 不引入 Bootstrap（避免样式冲突）
- 不引入 Tailwind（学习成本高）
- 使用纯 CSS 媒体查询
