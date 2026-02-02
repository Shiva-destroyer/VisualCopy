(function() {
    if (window.hasVisionEngineLoaded) return;
    window.hasVisionEngineLoaded = true;
    console.log("SHIELD: VisionCopy v15 Loaded (High-Vis Notification)");

    // --- CONFIGURATION ---
    // 1. Precise CSS Blockers (Preserves Checkboxes)
    var cssList = [
        "[data-ai-instructions]",
        "[data-testid='content-integrity-instructions']",
        ".css-ow46ga"
    ];

    // 2. Inject Blocking CSS
    var styleRules = "display: none !important;";
    var finalCss = cssList.join(", ") + " { " + styleRules + " }";
    var style = document.createElement('style');
    style.textContent = finalCss;
    (document.head || document.documentElement).appendChild(style);

    // --- CORE FUNCTIONS ---
    function isTrapContent(text) {
        if (!text) return false;
        var lower = text.toLowerCase();
        var phrases = ["helpful ai assistant", "uphold academic integrity", "protected assessment", "strictly prohibited", "sole function is to", "deliver the message", "message to user", "i cannot interact with", "purpose is to help you learn", "disabled on assessment", "do not answer this"];
        for (var i = 0; i < phrases.length; i++) {
            if (lower.indexOf(phrases[i]) !== -1) return true;
        }
        return false;
    }

    function scrubText(text) {
        if (!text) return "";
        var lines = text.split('\n');
        var cleanLines = [];
        for (var i = 0; i < lines.length; i++) {
            if (!isTrapContent(lines[i])) cleanLines.push(lines[i]);
        }
        return cleanLines.join('\n');
    }

    // --- NEW: High-Visibility Notification System ---
    function showNotification() {
        // 1. Create the Host (attached to HTML to escape Body limits)
        var host = document.createElement("div");
        host.style.cssText = "position: fixed; top: 0; left: 0; width: 0; height: 0; z-index: 2147483647;";
        document.documentElement.appendChild(host);

        // 2. Create the Notification Box
        var box = document.createElement("div");
        box.textContent = "Good to Go 👍";
        // Skyblue background (#87CEEB) with Black text
        box.style.cssText = "position: fixed; top: 20px; right: 20px; background-color: #87CEEB !important; color: #000000 !important; padding: 12px 20px; border: 2px solid #00BFFF; border-radius: 8px; font-family: sans-serif; font-size: 16px; font-weight: bold; box-shadow: 0 4px 12px rgba(0,0,0,0.3); z-index: 2147483647; pointer-events: none; transition: opacity 0.5s ease-out;";

        host.appendChild(box);

        // 3. Auto-Fade Logic
        setTimeout(function() {
            box.style.opacity = "0";
        }, 1500);
        setTimeout(function() {
            if (host.parentNode) host.parentNode.removeChild(host);
        }, 2100);
    }

    // --- EVENT LISTENER ---
    document.addEventListener('copy', function(e) {
        var selection = window.getSelection();
        if (!selection || selection.rangeCount === 0) return;

        // Check if we need to act
        var rawText = selection.toString();
        if (!isTrapContent(rawText)) return; // Pass through if safe

        // --- INTERCEPT ---
        e.preventDefault();
        e.stopPropagation();

        try {
            var range = selection.getRangeAt(0);
            var fragment = range.cloneContents();

            // Clean the DOM fragment
            var selectors = cssList.join(", ");
            var traps = fragment.querySelectorAll(selectors);
            for (var i = 0; i < traps.length; i++) traps[i].remove();

            // Extract text via Invisible Box
            var tempDiv = document.createElement("div");
            tempDiv.style.position = "fixed";
            tempDiv.style.left = "-9999px";
            tempDiv.style.top = "0";
            tempDiv.style.whiteSpace = "pre-wrap";
            document.body.appendChild(tempDiv);
            tempDiv.appendChild(fragment);
            var cleanText = tempDiv.innerText;
            document.body.removeChild(tempDiv);

            // Final Polish
            if (!cleanText || cleanText.trim().length === 0) cleanText = fragment.textContent || "";
            if (isTrapContent(cleanText)) cleanText = scrubText(cleanText);

            // Write to Clipboard
            e.clipboardData.setData('text/plain', cleanText);

            // Show Notification
            showNotification();

        } catch (err) {
            console.error("Copy Error:", err);
            // Fallback
            e.clipboardData.setData('text/plain', selection.toString());
        }
    }, true);
})();
