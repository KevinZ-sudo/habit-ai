import React, { useEffect, useState } from "react";

const UserInfo = () => {
  const [user, setUser] = useState(null);
  const [time, setTime] = useState(new Date());

  // Load user info from localStorage
  useEffect(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      try {
        setUser(JSON.parse(storedUser));
      } catch {
        console.warn("Invalid user JSON detected, clearing...");
        localStorage.removeItem("user");
        setUser(null);
      }
    }
  }, []);

  // Update time every second
  useEffect(() => {
    const timer = setInterval(() => setTime(new Date()), 1000);
    return () => clearInterval(timer);
  }, []);

  if (!user) {
    return (
      <div className="text-gray-500 italic">
        Not logged in
      </div>
    );
  }

  return (
    <div className="w-full">
      {/* Title */}
      <div className="flex items-center mb-3">
        <span className="text-3xl mr-2">👤</span>
        <h2 className="text-2xl font-bold text-gray-800">User Info</h2>
      </div>

      {/* User Details */}
      <div className="ml-2 text-gray-800">
        <p className="text-xl font-semibold mb-1">{user.username}</p>
        <p className="text-lg text-gray-600">{user.email}</p>
      </div>

      {/* Divider */}
      <hr className="my-4 border-gray-200" />

      {/* Live Clock */}
      <div className="text-gray-700 text-lg font-medium flex items-center">
        <span className="mr-2">🕒</span>
        {time.toLocaleString("en-US", {
          weekday: "long",
          hour: "2-digit",
          minute: "2-digit",
          second: "2-digit",
          hour12: true,
        })}
      </div>
    </div>
  );
};

export default UserInfo;
