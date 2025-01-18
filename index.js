function startAutoClicker(interval = 400) {
  const button = document.getElementById('bigCookie');

  if (!button) {
    console.error('Element with id "bigCookie" not found!');
    return;
  }

  let clicker = setInterval(() => {
    const event = new MouseEvent('click', { bubbles: true, cancelable: true });
    button.dispatchEvent(event);
    console.log('Click simulato su bigCookie!');
  }, interval);

  console.log(`Autoclicker started with ${interval} ms interval. Use stopAutoClicker() to stop it.`);

  // Returns a function to stop the autoclicker
  window.stopAutoClicker = () => {
    clearInterval(clicker);
    console.log('Autoclicker stopped.');
  };
}

// Starts the autoclicker with a defined interval
startAutoClicker();

//--------------------------------------------

function observeShimmers() {
  // Select item with id "shimmers"
  const shimmersContainer = document.getElementById("shimmers");
  if (!shimmersContainer) {
    console.error("Element with id 'shimmers' not found.");
    return;
  }

  // Creates an instance of MutationObserver
  const observer = new MutationObserver((mutationsList) => {
    for (const mutation of mutationsList) {
      if (mutation.type === "childList") {
        mutation.addedNodes.forEach((node) => {
          if (node.nodeType === Node.ELEMENT_NODE && node.classList.contains("shimmer")) {
            // Simulates a click on the added element
            node.click();

            // Select the element with id 'particle0'
            const particleElement = document.getElementById("particle0");

            if (particleElement) {
              // Function to extract all text from child nodes and concatenate them with a carriage return
              const extractTextRecursively = (element) => {
                let texts = [];
                element.childNodes.forEach((node) => {
                  if (node.nodeType === Node.TEXT_NODE) {
                    // Retrieves text from text nodes
                    const text = node.nodeValue.trim();
                    if (text) texts.push(text);
                  } else if (node.nodeType === Node.ELEMENT_NODE) {
                    // If it is an element, it recursively calls the function
                    texts.push(extractTextRecursively(node));
                  }
                });
                return texts.join("\n");
              };

              // Retrieves all text from the
              const fullText = extractTextRecursively(particleElement);

              // Show text in console
              console.log(fullText);
            } else {
              console.error("Element with id 'particle0' not found.");
            }

          }
        });
      }
    }
  });

  // Options for observation
  const config = { childList: true, subtree: false };

  // Observation starts
  observer.observe(shimmersContainer, config);

  console.log("Observation started on the element with id 'shimmers'.");
}

// Execute function
observeShimmers();
