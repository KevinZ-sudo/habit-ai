import React, { useEffect, useState } from "react";
import { getHabits, createHabit } from "../api/habits";

function HabitsPage() {
  const [habits, setHabits] = useState([]);
  const [newHabit, setNewHabit] = useState("");

  useEffect(() => {
    getHabits().then(setHabits).catch(console.error);
  }, []);

  const handleAdd = async (e) => {
    e.preventDefault();
    if (!newHabit.trim()) return;
    await createHabit({ name: newHabit });
    const updated = await getHabits();
    setHabits(updated);
    setNewHabit("");
  };

  return (
    <div>
      <h2>Your Habits</h2>
      <form onSubmit={handleAdd}>
        <input value={newHabit} onChange={(e) => setNewHabit(e.target.value)} placeholder="New Habit" />
        <button type="submit">Add</button>
      </form>
      <ul>
        {habits.map((h, i) => (
          <li key={i}>{h.name}</li>
        ))}
      </ul>
    </div>
  );
}

export default HabitsPage;
