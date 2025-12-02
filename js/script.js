function checkLogin() {
    fetch("/musicshop/api/whoami.php", { credentials: "include" })
        .then(r => r.json())
        .then(data => {
            const el = document.getElementById("userStatus");
            if (data.logged_in) {
                el.innerHTML = `Logged in as user #${data.user_id} (${data.role})`;
            } else {
                el.innerHTML = "Not logged in.";
            }
        })
        .catch(err => console.error(err));
}

checkLogin();
