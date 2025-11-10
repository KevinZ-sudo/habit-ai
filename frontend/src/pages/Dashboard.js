import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import UserInfo from "../components/UserInfo";
import HabitForm from "../components/HabitForm";
import HabitList from "../components/HabitList";
import AIAdvice from "../components/AIAdvice";

export default function Dashboard() {
  const [refreshKey, setRefreshKey] = useState(0);
  const navigate = useNavigate();

  const handleHabitAdded = () => {
    setRefreshKey((prev) => prev + 1);
  };

  const handleLogout = () => {
    localStorage.removeItem("user");
    localStorage.removeItem("token");
    navigate("/login");
  };

  // ✅ Login check: redirect if no token
  useEffect(() => {
    const token = localStorage.getItem("token");
    if (!token) {
      navigate("/login");
    }
  }, [navigate]);

  return (
    <div className="min-h-screen p-8 relative bg-gray-50">
      <button
        onClick={handleLogout}
        className="absolute top-6 right-6 z-10 bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg shadow-md transition"
      >
        Logout
      </button>

      <div className="grid grid-cols-2 grid-rows-2 gap-6 mt-16">
        <div className="card">
          <UserInfo />
        </div>

        <div className="card">
          <AIAdvice />
        </div>

        <div className="card">
          <HabitForm onHabitAdded={handleHabitAdded} />
        </div>

        <div className="card overflow-auto">
          <HabitList refreshKey={refreshKey} />
        </div>
      </div>
    </div>
  );
}
