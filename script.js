/* =========================================================
   Chez Framboise — interactions
   - Header qui se solidifie au scroll
   - Menu mobile burger
   - Reveal au scroll (IntersectionObserver)
   - Hero : retrait du zoom initial (Ken Burns inversé)
   - Lightbox image pour la galerie
   - Fermeture du menu mobile au clic sur un lien
   ========================================================= */

(() => {
  'use strict';

  /* ---------- 1. Header : changement d'état au scroll ---------- */
  const header = document.querySelector('[data-header]');
  const onScroll = () => {
    if (!header) return;
    header.classList.toggle('is-scrolled', window.scrollY > 40);
  };
  document.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  /* ---------- 2. Menu burger mobile ---------- */
  const burger      = document.querySelector('[data-burger]');
  const mobileMenu  = document.querySelector('[data-mobile-menu]');
  const toggleMenu  = (open) => {
    if (!burger || !mobileMenu) return;
    const willOpen = open ?? !burger.classList.contains('is-open');
    burger.classList.toggle('is-open', willOpen);
    mobileMenu.classList.toggle('is-open', willOpen);
    burger.setAttribute('aria-expanded', String(willOpen));
    mobileMenu.setAttribute('aria-hidden', String(!willOpen));
    document.body.style.overflow = willOpen ? 'hidden' : '';
  };
  burger?.addEventListener('click', () => toggleMenu());
  // Fermer le menu quand on clique sur un lien interne
  mobileMenu?.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => toggleMenu(false));
  });
  // Échap pour fermer
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      toggleMenu(false);
      closeLightbox();
    }
  });

  /* ---------- 3. Hero : démarrer la transition d'image après le load ---------- */
  const hero = document.querySelector('.hero');
  requestAnimationFrame(() => hero?.classList.add('is-ready'));

  /* ---------- 4. Reveal au scroll ---------- */
  const reveals = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    const io = new IntersectionObserver((entries) => {
      entries.forEach((entry, i) => {
        if (entry.isIntersecting) {
          // Léger décalage progressif pour les éléments groupés
          const delay = Math.min(i * 60, 240);
          setTimeout(() => entry.target.classList.add('is-visible'), delay);
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });
    reveals.forEach(el => io.observe(el));
  } else {
    reveals.forEach(el => el.classList.add('is-visible'));
  }

  /* ---------- 5. Lightbox galerie ---------- */
  const lightbox    = document.querySelector('[data-lightbox]');
  const lightboxImg = lightbox?.querySelector('img');
  const closeBtn    = lightbox?.querySelector('[data-lightbox-close]');

  const openLightbox = (src, alt) => {
    if (!lightbox || !lightboxImg) return;
    lightboxImg.src = src;
    lightboxImg.alt = alt || '';
    lightbox.classList.add('is-open');
    lightbox.setAttribute('aria-hidden', 'false');
    document.body.style.overflow = 'hidden';
  };
  function closeLightbox() {
    if (!lightbox) return;
    lightbox.classList.remove('is-open');
    lightbox.setAttribute('aria-hidden', 'true');
    document.body.style.overflow = '';
  }

  document.querySelectorAll('.gallery__item img').forEach(img => {
    img.addEventListener('click', () => openLightbox(img.src, img.alt));
  });
  // Fermer en cliquant en dehors de l'image ou sur le bouton
  lightbox?.addEventListener('click', (e) => {
    if (e.target === lightbox) closeLightbox();
  });
  closeBtn?.addEventListener('click', closeLightbox);
})();
