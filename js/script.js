function checkLogin() {
    fetch("/musicshop/api/whoami.php", { credentials: "include" })
        .then(r => r.json())
        .then(data => {
            const el = document.getElementById("userStatus");
            if (!el) return;
            if (data.logged_in) {
                const username = (data.username || "").trim() || `User #${data.user_id}`;
                el.textContent = data.role === "admin" ? `${username} [Admin]` : username;
            } else {
                el.textContent = "Не сте влезли.";
            }
        })
        .catch(err => console.error(err));
}

checkLogin();
