---
layout: default
hide_title: true
---
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
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
<canvas id="bgCanvas" class="background-canvas"></canvas>

<!-- Hero Section -->
<div class="hero">
      <!-- GitHub Corner -->
<a href="https://github.com/OHPG" class="github-corner" aria-label="View on GitHub">
  <svg width="80" height="80" viewBox="0 0 250 250" style="fill:var(--primary); color:#000; position: absolute; top: 0; border: 0; right: 0;" aria-hidden="true">
    <path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path>
    <path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path>
    <path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path>
  </svg>
</a>
  <div class="container">
    <nav class="nav">
      <div class="logo">OHPG</div>
    </nav>
    
    <div class="hero-content" data-aos="fade-up">
      <h1>创新技术 <span class="highlight">优质体验</span></h1>
      <p class="subtitle">Full Stack Developer | Open Source Enthusiast</p>
      <div class="hero-cta">
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
  <div class="project-showcase" data-aos="fade-up" id="{{ project.name }}">
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
    
    // 背景动效增强
    const canvas = document.getElementById('bgCanvas');
    const ctx = canvas.getContext('2d');
    
    // 设置 canvas 尺寸
    function setCanvasSize() {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    }
    setCanvasSize();
    window.addEventListener('resize', setCanvasSize);

    // 简化的粒子类
    class Particle {
      constructor() {
        this.reset();
      }

      reset() {
        this.x = Math.random() * canvas.width;
        this.y = Math.random() * canvas.height;
        this.size = Math.random() * 2 + 0.5;
        this.speedX = (Math.random() - 0.5) * 0.5; // 降低速度
        this.speedY = (Math.random() - 0.5) * 0.5;
        this.opacity = Math.random() * 0.3 + 0.1; // 降低透明度
        this.color = this.getRandomColor();
      }

      getRandomColor() {
        const colors = [
          `rgba(59, 244, 251, ${this.opacity})`,
          `rgba(50, 255, 165, ${this.opacity})`
        ];
        return colors[Math.floor(Math.random() * colors.length)];
      }

      update() {
        this.x += this.speedX;
        this.y += this.speedY;
        
        // 简化的边界检查
        if (this.x < 0 || this.x > canvas.width || 
            this.y < 0 || this.y > canvas.height) {
          this.reset();
        }
      }

      draw() {
        ctx.beginPath();
        ctx.fillStyle = this.color;
        ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        ctx.fill();
      }
    }
        
    // 优化的连线函数
    function drawLines() {
            ctx.beginPath();
      for (let i = 0; i < particles.length; i += 2) { // 减少循环次数
        for (let j = i + 1; j < Math.min(i + 5, particles.length); j++) { // 限制连线数量
          const dx = particles[i].x - particles[j].x;
          const dy = particles[i].y - particles[j].y;
          const distance = dx * dx + dy * dy; // 避免开方运算
          const maxDistance = 10000; // 150 * 150

          if (distance < maxDistance) {
            ctx.moveTo(particles[i].x, particles[i].y);
            ctx.lineTo(particles[j].x, particles[j].y);
          }
        }
      }
      ctx.strokeStyle = 'rgba(59, 244, 251, 0.03)';
      ctx.stroke();
    }

    // 简化的鼠标交互
    let mouse = {
      x: null,
      y: null,
      radius: 100
    };

    function handleMouseInteraction() {
      if (!mouse.x || !mouse.y) return;
      
      for (let i = 0; i < particles.length; i += 2) { // 减少循环次数
        const particle = particles[i];
        const dx = particle.x - mouse.x;
        const dy = particle.y - mouse.y;
        const distance = dx * dx + dy * dy;
        
        if (distance < mouse.radius * mouse.radius) {
          particle.x += dx * 0.02;
          particle.y += dy * 0.02;
        }
      }
    }

    // 减少粒子数量
    const particles = [];
    const particleCount = Math.min(window.innerWidth / 20, 40); // 减少粒子数量

    for (let i = 0; i < particleCount; i++) {
      particles.push(new Particle());
    }

    // 优化的动画循环
    let animationFrameId;
    let lastTime = 0;
    const fps = 30; // 限制帧率
    const fpsInterval = 1000 / fps;
    function animate(currentTime) {
      animationFrameId = requestAnimationFrame(animate);

      // 控制帧率
      const elapsed = currentTime - lastTime;
      if (elapsed < fpsInterval) return;
      lastTime = currentTime - (elapsed % fpsInterval);

      // 使用半透明矩形而不是完全清除画布
      ctx.fillStyle = 'rgba(0, 0, 0, 0.1)';
      ctx.fillRect(0, 0, canvas.width, canvas.height);
      
      // 更新和绘制粒子
      particles.forEach(particle => {
        particle.update();
        particle.draw();
    });

      // 绘制连线
      drawLines();
      
      // 处理鼠标交互
      handleMouseInteraction();
    }

    // 事件监听器
    canvas.addEventListener('mousemove', function(event) {
      mouse.x = event.x;
      mouse.y = event.y;
    }, { passive: true });
    canvas.addEventListener('mouseleave', function() {
      mouse.x = null;
      mouse.y = null;
    });

    // 优化的触摸事件
    canvas.addEventListener('touchmove', function(event) {
      mouse.x = event.touches[0].clientX;
      mouse.y = event.touches[0].clientY;
    }, { passive: true });

    canvas.addEventListener('touchend', function() {
      mouse.x = null;
      mouse.y = null;
    });

    // 页面可见性优化
    document.addEventListener('visibilitychange', function() {
      if (document.hidden) {
        cancelAnimationFrame(animationFrameId);
      } else {
        lastTime = 0;
    animate();
      }
    });

    // 开始动画
    animate();

    // 初始化设备预览
    function initDevicePreview() {
      const deviceViews = document.querySelectorAll('.device-view');
      
      deviceViews.forEach(deviceView => {
        const indicators = deviceView.querySelectorAll('.indicator');
        
        indicators.forEach((indicator) => {
        indicator.addEventListener('click', function() {
            // 如果已经是激活状态，则不执行
            if (this.classList.contains('active')) return;
            // 移除其他激活状态
            indicators.forEach(i => {
              if (i.classList.contains('active')) {
                // 添加退出动画
                i.classList.add('indicator-leave');
                setTimeout(() => {
                  i.classList.remove('active', 'indicator-leave');
                }, 300);
              }
            });
            
            // 添加当前激活状态
            this.classList.add('indicator-enter');
            setTimeout(() => {
              this.classList.add('active');
              this.classList.remove('indicator-enter');
            }, 300);
            
            // 更新预览图片
          const previewImages = this.closest('.device-preview')
            .querySelector('.preview-images');
          const targetImage = previewImages
            .querySelector(`[data-index="${this.dataset.index}"]`);
          
          if (targetImage) {
              const currentActive = previewImages.querySelector('.preview-img.active');
              
              // 添加图片切换动画
              if (currentActive) {
                currentActive.style.transition = 'opacity 0.3s ease';
                currentActive.style.opacity = '0';
                setTimeout(() => {
                  currentActive.classList.remove('active');
            targetImage.classList.add('active');
                  targetImage.style.opacity = '0';
                  requestAnimationFrame(() => {
                    targetImage.style.transition = 'opacity 0.3s ease';
                    targetImage.style.opacity = '1';
          });
                }, 300);
    }
            }
});
        });
      });
    }
            
    // 调用初始化
    initDevicePreview();
});
</script>
