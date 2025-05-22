// Custom animation effects for PathCode
document.addEventListener('DOMContentLoaded', function() {
    
    // Add glowing effect to code particles when hovering
    document.addEventListener('mousemove', function(e) {
        const particles = document.querySelectorAll('.code-particle');
        const mouseX = e.clientX;
        const mouseY = e.clientY;
        
        particles.forEach(particle => {
            const rect = particle.getBoundingClientRect();
            const centerX = rect.left + rect.width / 2;
            const centerY = rect.top + rect.height / 2;
            
            // Calculate distance between mouse and particle center
            const distance = Math.sqrt(
                Math.pow(mouseX - centerX, 2) + 
                Math.pow(mouseY - centerY, 2)
            );
            
            // Apply glow effect based on distance
            if (distance < 300) {
                const intensity = 1 - (distance / 300); // 0 to 1, closer = more intense
                const glow = `0 0 ${Math.round(intensity * 20)}px rgba(56, 189, 248, ${intensity * 0.7})`;
                const scale = 1 + (intensity * 0.1);
                
                particle.style.boxShadow = glow;
                particle.style.transform = `scale(${scale})`;
                particle.style.zIndex = "0";
                
                // Slow down the animation slightly when close to mouse
                if (distance < 150) {
                    particle.style.animationPlayState = 'paused';
                    setTimeout(() => {
                        particle.style.animationPlayState = 'running';
                    }, 500);
                }
            } else {
                particle.style.boxShadow = 'none';
                // Only reset transform if particle doesn't have inline scale style from creation
                if (!particle.style.transform.includes('scale(0.')) {
                    particle.style.transform = 'scale(1)';
                }
                particle.style.zIndex = "-1";
            }
        });
    });
    
    // Add typing effect to code blocks
    function addTypingEffect() {
        const codeElements = document.querySelectorAll('pre code:not(.typing-effect-applied)');
        
        codeElements.forEach(element => {
            element.classList.add('typing-effect-applied');
            
            const text = element.textContent;
            element.textContent = '';
            element.style.display = 'block';
            
            let i = 0;
            const interval = setInterval(() => {
                if (i < text.length) {
                    element.textContent += text.charAt(i);
                    i++;
                } else {
                    clearInterval(interval);
                }
            }, 20);
        });
    }
    
    // Apply typing effect when scrolling near code blocks
    let typingApplied = false;
    window.addEventListener('scroll', function() {
        if (!typingApplied) {
            const codeElements = document.querySelectorAll('pre code');
            if (codeElements.length > 0) {
                const firstCodeElement = codeElements[0];
                const rect = firstCodeElement.getBoundingClientRect();
                
                if (rect.top < window.innerHeight) {
                    addTypingEffect();
                    typingApplied = true;
                }
            }
        }
    });
    
    // Connect code particles with lines when they're close to each other
    setInterval(() => {
        const particles = document.querySelectorAll('.code-particle');
        const connectors = document.querySelectorAll('.particle-connector');
        
        // Remove old connectors
        connectors.forEach(connector => connector.remove());
        
        // Create new connectors
        for (let i = 0; i < particles.length; i++) {
            for (let j = i + 1; j < particles.length; j++) {
                const particle1 = particles[i];
                const particle2 = particles[j];
                
                const rect1 = particle1.getBoundingClientRect();
                const rect2 = particle2.getBoundingClientRect();
                
                const center1 = {
                    x: rect1.left + rect1.width / 2,
                    y: rect1.top + rect1.height / 2
                };
                
                const center2 = {
                    x: rect2.left + rect2.width / 2,
                    y: rect2.top + rect2.height / 2
                };
                
                const distance = Math.sqrt(
                    Math.pow(center1.x - center2.x, 2) + 
                    Math.pow(center1.y - center2.y, 2)
                );
                
                // Connect particles that are close to each other
                if (distance < 250) {
                    const opacity = 1 - (distance / 250);
                    
                    const connector = document.createElement('div');
                    connector.classList.add('particle-connector');
                    connector.style.position = 'fixed';
                    connector.style.height = '1px';
                    connector.style.backgroundColor = `rgba(56, 189, 248, ${opacity * 0.3})`;
                    connector.style.zIndex = '-2';
                    connector.style.pointerEvents = 'none';
                    
                    // Calculate position and dimensions
                    const angle = Math.atan2(center2.y - center1.y, center2.x - center1.x);
                    const length = distance;
                    
                    connector.style.width = `${length}px`;
                    connector.style.left = `${center1.x}px`;
                    connector.style.top = `${center1.y}px`;
                    connector.style.transformOrigin = '0 0';
                    connector.style.transform = `rotate(${angle}rad)`;
                    
                    document.body.appendChild(connector);
                }
            }
        }
    }, 200);
}); 