import React from "react";

const UserPanel = () => {
  let user = { username: "Guest", email: "N/A" };
  const raw = localStorage.getItem("user");

  if (raw) {
    try {
      user = JSON.parse(raw);
    } catch {
      console.warn("Invalid user data in localStorage, resetting...");
      localStorage.removeItem("user");
    }
  }

  return (
    <div className="user-panel">
      <h2>Welcome, {user.username}</h2>
      <p>{user.email}</p>
    </div>
  );
};

export default UserPanel;
