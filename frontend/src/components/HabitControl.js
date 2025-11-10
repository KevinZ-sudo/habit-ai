import React, { useState } from "react";
import { Plus } from "lucide-react";
import { createHabit } from "../api/habitApi";

export default function HabitControl({ setHabits }) {
  const [title, setTitle] = useState("");
  const [habitTime, setHabitTime] = useState("");
  const token = localStorage.getItem("token");

  const handleAdd = async () => {
    if (!title || !habitTime) return alert("Please enter title and time");
    const newHabit = { title, habit_time: habitTime };
    const res = await createHabit(token, newHabit);
    setHabits((prev) => [...prev, res]);
    setTitle("");
    setHabitTime("");
  };

  return (
    <div>
      <h2 className="text-lg font-semibold mb-4">Add a New Habit</h2>
      <input
        type="text"
        placeholder="Enter habit title"
        className="w-full p-2 rounded bg-white/20 text-white mb-3 focus:outline-none focus:ring-2 focus:ring-blue-400"
        value={title}
        onChange={(e) => setTitle(e.target.value)}
      />
      <input
        type="datetime-local"
        className="w-full p-2 rounded bg-white/20 text-white mb-4 focus:outline-none focus:ring-2 focus:ring-blue-400"
        value={habitTime}
        onChange={(e) => setHabitTime(e.target.value)}
      />
      <button
        onClick={handleAdd}
        className="flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 w-full py-2 rounded-lg transition-all shadow-lg"
      >
        <Plus size={18} /> Add Habit
      </button>
    </div>
  );
}
