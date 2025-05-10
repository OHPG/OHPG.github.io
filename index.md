---
layout: default
title: Home
---
<!-- 在文件顶部添加样式链接 -->
<link rel="stylesheet" href="{{ '/assets/css/style.css' | relative_url }}">
<link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>

<!-- 在文件顶部添加 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">

<!-- Hero Section -->
<div class="hero">
  <div class="container">
    <nav class="nav">
      <div class="logo">OHPG</div>
    </nav>
    
    <div class="hero-content" data-aos="fade-up">
      <h1>创新技术 <span class="highlight">优质体验</span></h1>
      <p class="subtitle">Full Stack Developer | Open Source Enthusiast</p>
      <div class="hero-cta">
        <a href="#projects" class="cta-button">查看作品</a>
        <a href="https://github.com/OHPG" class="cta-button secondary">GitHub</a>
    </div>
  </div>

    <!-- Summary Stats -->
    <div class="summary-stats" data-aos="fade-up" data-aos-delay="200">
      {% for stat in site.data.summary.stats %}
      <div class="stat-item">
        <span class="stat-value">{{ stat.value }}</span>
        <span class="stat-label">{{ stat.label }}</span>
</div>
          {% endfor %}
        </div>

    <!-- Project Logo List -->
    <div class="project-list" data-aos="fade-up" data-aos-delay="400">
      <div class="project-scroll">
        {% for project in site.data.summary.projects %}
        <a href="{{ project.link }}" class="project-logo-card">
          <img src="{{ project.icon }}" alt="{{ project.name }}" class="project-logo">
          <span class="project-name">{{ project.name }}</span>
            </a>
                {% endfor %}
  </div>
    </div>
  </div>
  </div>

<!-- Projects Section -->
<section id="projects" class="projects-section">
  <div class="container">
  {% for project in site.data.projects %}
  <div class="project-showcase" data-aos="fade-up">
      <header class="project-header">
        <h1 class="project-title">{{ project.name }}</h1>
        <div class="project-meta">
          <div class="meta-item">
            <i class="ri-github-fill"></i>
            <span>{{ project.github_url | split: '/' | last }}</span>
    </div>
          <div class="meta-item">
            <i class="ri-calendar-line"></i>
            <span>{{ project.calendar }}</span>
  </div>
          </div>
        <div class="tag-list">
          {% for tag in project.tags %}
          <span class="tag">{{ tag }}</span>
          {% endfor %}
        </div>
        <p class="project-description">{{ project.description }}</p>
      </header>

      <section class="devices-section">
        <h2 class="section-title">多端适配</h2>
        <div class="devices-tabs">
          {% for device in project.devices %}
          <button class="device-tab {% if forloop.first %}active{% endif %}" data-device="{{ device.type }}">
            <i class="ri-{{ device.icon }}"></i>
            <span>{{ device.name }}</span>
          </button>
          {% endfor %}
        </div>
        
        <div class="devices-content">
          {% for device in project.devices %}
          <div class="device-view {% if forloop.first %}active{% endif %}" data-device="{{ device.type }}">
            <div class="device-preview {% if forloop.first %}show{% endif %}">
              <div class="preview-images">
                {% for preview in device.previews %}
                <img src="{{ preview.image }}"
                     class="preview-img {% if forloop.first %}active{% endif %}"
                     data-index="{{ forloop.index0 }}"
                     alt="{{ preview.title }}">
        {% endfor %}
      </div>
              <div class="preview-indicators">
                {% for preview in device.previews %}
                <div class="indicator {% if forloop.first %}active{% endif %}"
                     data-index="{{ forloop.index0 }}">
                  <h3>{{ preview.title }}</h3>
                  <p>{{ preview.description }}</p>
    </div>
                {% endfor %}
  </div>
    </div>
  </div>
  {% endfor %}
  </div>
</section>
    </div>
    {% endfor %}
  </div>
</section>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // 初始化 AOS
    AOS.init({
      duration: 1000,
      once: true
    });

     // 设备类型切换
    const deviceTabs = document.querySelectorAll('.device-tab');
    deviceTabs.forEach(tab => {
        tab.addEventListener('click', function(e) {
            // 获取当前 tab 的索引位置
            const tabContainer = tab.closest('.devices-tabs');
            const tabs = Array.from(tabContainer.querySelectorAll('.device-tab'));
            const clickedIndex = tabs.indexOf(tab);
            
            // 设置 data-active 属性
            tabContainer.setAttribute('data-active', clickedIndex.toString());

            // 创建波纹效果
            const ripple = document.createElement('span');
            ripple.classList.add('ripple');
            const rect = tab.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';
            tab.appendChild(ripple);
            
            // 移除旧的波纹
            setTimeout(() => ripple.remove(), 800);

            const device = tab.dataset.device;
            const container = tab.closest('.devices-section');
            
            // 更新标签状态
            container.querySelectorAll('.device-tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            
            // 更新设备视图
            const views = container.querySelectorAll('.device-view');
            const activeView = container.querySelector(`.device-view[data-device="${device}"]`);
            
            // 淡出当前视图
            views.forEach(view => {
                if (view !== activeView) {
                    view.querySelector('.device-preview')?.classList.remove('show');
                    setTimeout(() => {
                        view.classList.remove('active');
                    }, 300);
                }
            });

            // 淡入新视图
            if (activeView) {
                setTimeout(() => {
                    activeView.classList.add('active');
                    setTimeout(() => {
                        activeView.querySelector('.device-preview')?.classList.add('show');
                    }, 50);
                }, 300);
            }
        });
    });

    // 图片和指示器联动
    const indicators = document.querySelectorAll('.indicator');
    indicators.forEach(indicator => {
        indicator.addEventListener('click', () => {
            const index = indicator.dataset.index;
            const deviceView = indicator.closest('.device-view');
            
            // 更新指示器状态
            deviceView.querySelectorAll('.indicator').forEach(i => i.classList.remove('active'));
            indicator.classList.add('active');
            
            // 更新图片状态
            deviceView.querySelectorAll('.preview-img').forEach(img => {
                img.classList.remove('active');
                if (img.dataset.index === index) {
                    img.classList.add('active');
                }
            });
        });
    });

    // 添加hover时的光晕效果
    deviceTabs.forEach(tab => {
        tab.addEventListener('mousemove', function(e) {
            const rect = tab.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            
            tab.style.setProperty('--x', `${x}px`);
            tab.style.setProperty('--y', `${y}px`);
        });
    });
    
});
</script>