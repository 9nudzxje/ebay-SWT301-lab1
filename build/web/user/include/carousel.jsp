<div id="slide_ad" class="relative w-full h-[350px] bg-gray-200 rounded-lg overflow-hidden">
    <div id="slider" class="flex overflow-x-scroll snap-x snap-mandatory scroll-smooth w-full">
        <div id="slide1" class=" relative flex-shrink-0 w-full h-auto object-cover snap-center">
            <img src="resources/images/kfc-banner.png" alt="DIY Car Guide" class="w-auto h-auto object-cover">
                <div class="absolute top-0 left-0 z-10 p-8 max-w-xl">
                    <h2 class="text-4xl font-semibold text-white">KFC in your Area</h2>
                    <p class="mt-4 text-lg font-semibold text-white">What makes you hungry, try kfc right now.</p>
                    <p class=" text-lg font-semibold text-white">Sheeeesh.</p>
                    <a href="./search-product?categorySelect=29&searchKey=&brandSelect=0&priceRange=allRange&sortOrder=" class="inline-block mt-6 px-6 py-3 bg-white text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">Shopping</a>
                </div>
        </div>
        <div id="slide2" class="relative flex-shrink-0 w-full h-auto object-cover snap-center">
            <img src="resources/images/banner-gear.png" alt="Slide 2" class="w-auto h-auto object-cover">
                <div class="absolute top-0 left-0 z-10 p-8 max-w-xl">
                    <h2 class="text-4xl font-bold text-white">EA gaming cards</h2>
                    <a href="./search-product?categorySelect=30&searchKey=&brandSelect=0&priceRange=allRange&sortOrder=" class="inline-block mt-6 px-6 py-3 bg-white text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">Shopping</a>
                </div>
        </div>
        <div id="slide3" class="relative flex-shrink-0 w-full h-auto object-cover snap-center">
            <img src="resources/images/clothing-banner.png" alt="Slide 3" class="w-auto h-auto object-cover">
                <div class="absolute top-0 left-0 z-10 p-8 max-w-xl">
                    <h2 class="text-4xl font-bold text-white">Fashion 2024</h2>
                    <p class="mt-4 text-lg text-white">New clothes, new age.</p>
                    <a href="./search-product?categorySelect=20&searchKey=&brandSelect=0&priceRange=allRange&sortOrder=" class="inline-block mt-6 px-6 py-3 bg-white text-black font-semibold rounded-full hover:scale-95 transform transition duration-150">Shopping</a>
                </div>
        </div>
    </div>
    <div class="absolute bottom-4 right-4 flex items-center space-x-2">
        <button id="prebutton" class="p-2 rounded-full bg-white hover:bg-gray-200">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
        </button>
        <button id="nextbutton" class="p-2 rounded-full bg-white hover:bg-gray-200">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
        </button>
        <button id="pause" class="p-2 rounded-full bg-white hover:bg-gray-200">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 9v6m4-6v6" />
            </svg>
        </button>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const slider = document.getElementById("slider");
        const slides = slider.children;
        const preButton = document.getElementById("prebutton");
        const nextButton = document.getElementById("nextbutton");
        const pauseButton = document.getElementById("pause");
        const totalSlides = slides.length;
        let currentSlide = 0;
        let autoSlideInterval;
        let isPaused = false;

        // Function to go to a specific slide
        function goToSlide(slideIndex) {
            if (slideIndex < 0) {
                currentSlide = totalSlides - 1;
            } else if (slideIndex >= totalSlides) {
                currentSlide = 0;
            } else {
                currentSlide = slideIndex;
            }

            const slideWidth = slides[currentSlide].clientWidth;
            slider.scrollTo({
                left: slideWidth * currentSlide,
                behavior: 'smooth'
            });
        }

        // Start auto sliding
        function startAutoSlide() {
            autoSlideInterval = setInterval(function () {
                goToSlide(currentSlide + 1);
            }, 3000); // Slide every 3 seconds
        }

        // Stop auto sliding
        function stopAutoSlide() {
            clearInterval(autoSlideInterval);
        }

        // Add event listeners to buttons
        preButton.addEventListener('click', function () {
            goToSlide(currentSlide - 1);
        });

        nextButton.addEventListener('click', function () {
            goToSlide(currentSlide + 1);
        });

        pauseButton.addEventListener('click', function () {
            if (isPaused) {
                startAutoSlide();
                pauseButton.innerHTML = `
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 9v6m4-6v6" />
                </svg>`;
                isPaused = false;
            } else {
                stopAutoSlide();
                pauseButton.innerHTML = `
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 6l12 12m-12 0l12-12" />
                </svg>`;
                isPaused = true;
            }
        });

        startAutoSlide();
    });
</script>

