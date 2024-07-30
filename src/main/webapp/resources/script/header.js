window.addEventListener('load', function() {  

    /* 사이드바 열기 */
    const menu = document.querySelector('.nav__menu');
    const toggleBtn = document.querySelector('.nav_toggle_btn');
    
    toggleBtn.addEventListener('click', () => {
      menu.classList.toggle('active_menu');
    });
    
});

