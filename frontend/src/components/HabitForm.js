import React, { useState } from "react";
import axios from "axios";

export default function HabitForm({ onHabitAdded }) {
  const [title, setTitle] = useState("");
  const [date, setDate] = useState(() => {
    const today = new Date().toISOString().split("T")[0];
    return today;
  });
  const [startTime, setStartTime] = useState("");
  const [endTime, setEndTime] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!title || !startTime || !endTime) return;

    try {
      const token = localStorage.getItem("token");

      const start = new Date(`${date}T${startTime}`);
      const end = new Date(`${date}T${endTime}`);

      await axios.post(
        "http://127.0.0.1:8000/habits/",
        {
          title,
          start_time: start.toISOString(),
          end_time: end.toISOString(),
          completed: false,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        }
      );

      setTitle("");
      setStartTime("");
      setEndTime("");
      if (onHabitAdded) onHabitAdded();
    } catch (err) {
      console.error("Failed to add habit:", err.response?.data || err);
      alert("Error adding habit");
    }
  };

  return (
    <div>
      <h2 className="text-2xl font-semibold mb-4">🧭 Habit Control</h2>
      <form onSubmit={handleSubmit} className="space-y-4">
        <input
          type="text"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Enter habit name"
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none"
          required
        />

        <input
          type="date"
          value={date}
          onChange={(e) => setDate(e.target.value)}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none"
        />

        <div className="flex gap-3">
          <input
            type="time"
            value={startTime}
            onChange={(e) => setStartTime(e.target.value)}
            className="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none"
            required
          />
          <input
            type="time"
            value={endTime}
            onChange={(e) => setEndTime(e.target.value)}
            className="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none"
            required
          />
        </div>

        <button
          type="submit"
          className="w-full bg-blue-600 text-white font-semibold py-2 rounded-lg hover:bg-blue-700 transition duration-200"
        >
          + Add Habit
        </button>
      </form>
    </div>
  );
}
