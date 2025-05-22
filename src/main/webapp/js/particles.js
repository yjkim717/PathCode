// Code Particles Animation for PathCode
document.addEventListener('DOMContentLoaded', function() {
    // Create particle container if not exists
    let particleContainer = document.getElementById('particle-container');
    if (!particleContainer) {
        particleContainer = document.createElement('div');
        particleContainer.id = 'particle-container';
        document.body.prepend(particleContainer);
    }
    
    // Enhanced code snippets with consistent formatting and multiline support
    const codeSnippets = [
        `if (x > 10) { 
  return true; 
}`,
        `import React from "react";
import { useState } from "react";
function App() {
  return <div>;
}`,
        `function getUser(id) { 
  return fetch('/api/users/' + id);
}`, 
        `const data = await fetch(url);
const json = await data.json();`, 
        `class CodeParticle {
  constructor() {
    this.visible = true;
  }
}`, 
        `let array = [1, 2, 3, 4];
array.map(x => x * 2);`,
        `for (let i = 0; i < 10; i++) { 
  console.log(i);
}`,
        `// Database query
SELECT * FROM users 
WHERE active = true;`,
        `try {
  doSomething();
} catch (error) {
  console.error(error);
}`
    ];
    
    // Track existing particle positions to avoid overlap
    const activePositions = [];
    
    function createParticle() {
        // Clear out any outdated position records (older than 5 seconds)
        const now = Date.now();
        while (activePositions.length > 0 && now - activePositions[0].timestamp > 5000) {
            activePositions.shift();
        }
        
        const particle = document.createElement('div');
        particle.classList.add('code-particle');
        
        // Find a position that doesn't overlap with existing particles
        let posX, posY, attempts = 0;
        let validPosition = false;
        
        while (!validPosition && attempts < 10) {
            posX = Math.random() * (window.innerWidth - 350); // Account for particle width
            posY = Math.random() * window.innerHeight * 0.7 + window.innerHeight * 0.3; // Bottom 70% of screen
            
            // Check if position overlaps with existing particles
            validPosition = true;
            for (const pos of activePositions) {
                const distance = Math.sqrt(Math.pow(posX - pos.x, 2) + Math.pow(posY - pos.y, 2));
                if (distance < 300) { // Minimum distance between particles
                    validPosition = false;
                    break;
                }
            }
            attempts++;
        }
        
        // If we couldn't find a valid position after 10 attempts, just use the last one
        if (validPosition) {
            activePositions.push({
                x: posX,
                y: posY,
                timestamp: Date.now()
            });
        }
        
        // Random code snippet
        const snippet = codeSnippets[Math.floor(Math.random() * codeSnippets.length)];
        
        // Random size and duration
        const size = Math.random() * 0.2 + 0.8; // 0.8 to 1.0
        const duration = Math.random() * 8 + 22; // 22 to 30 seconds
        
        particle.style.left = `${posX}px`;
        particle.style.bottom = `${-50}px`; // Start below the screen
        particle.style.transform = `scale(${size})`;
        particle.style.animationDuration = `${duration}s`;
        particle.style.opacity = '0';
        particle.textContent = snippet;
        
        particleContainer.appendChild(particle);
        
        // Remove particle after animation completes
        setTimeout(() => {
            particle.remove();
        }, duration * 1000);
    }
    
    // Create particles at intervals (less frequent for better performance)
    setInterval(createParticle, 3500);
    
    // Create initial particles (fewer and staggered for smoother start)
    for (let i = 0; i < 5; i++) {
        setTimeout(createParticle, i * 800);
    }
    
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
}); 