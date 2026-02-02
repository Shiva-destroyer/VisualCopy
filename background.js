browser.contextMenus.create({
    id: "vision-copy",
    title: "🛡️ Vision Copy (Force Clean)",
                            contexts: ["selection"]
});

browser.contextMenus.onClicked.addListener((info, tab) => {
    if (info.menuItemId === "vision-copy") {
        browser.scripting.executeScript({
            target: { tabId: tab.id, allFrames: true },
            files: ["vision_engine.js"]
        });
    }
});
