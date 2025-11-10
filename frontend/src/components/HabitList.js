import React, { useEffect, useState, useCallback } from "react";
import ReactDOM from "react-dom";
import axios from "axios";

export default function HabitList({ refreshKey }) {
  const [habits, setHabits] = useState([]);
  const [selectedHabit, setSelectedHabit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const token = localStorage.getItem("token");

  const fetchHabits = useCallback(async () => {
    try {
      const res = await axios.get("http://127.0.0.1:8000/habits/", {
        headers: { Authorization: `Bearer ${token}` },
      });
      const sorted = [...res.data].sort(
        (a, b) => new Date(b.start_time) - new Date(a.start_time)
      );
      setHabits(sorted.slice(0, 10));
    } catch (err) {
      console.error("Failed to fetch habits:", err);
    }
  }, [token]);

  useEffect(() => {
    fetchHabits();
  }, [fetchHabits, refreshKey]);

  const formatDateRange = (start, end) => {
    if (!start || !end) return "—";
    try {
      const startFixed = new Date(start.replace(" ", "T"));
      const endFixed = new Date(end.replace(" ", "T"));
      const dateFormatter = new Intl.DateTimeFormat("en-AU", {
        day: "2-digit",
        month: "2-digit",
        year: "numeric",
      });
      const timeFormatter = new Intl.DateTimeFormat("en-AU", {
        hour: "numeric",
        minute: "2-digit",
        hour12: true,
      });
      const datePart = dateFormatter.format(startFixed);
      const startTime = timeFormatter.format(startFixed).toLowerCase();
      const endTime = timeFormatter.format(endFixed).toLowerCase();
      return `${datePart}, ${startTime} - ${endTime}`;
    } catch {
      return "Invalid Date";
    }
  };

  const openEditModal = (habit) => {
    setSelectedHabit({ ...habit });
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
    setSelectedHabit(null);
  };

  const handleSave = async () => {
    try {
      await axios.put(
        `http://127.0.0.1:8000/habits/${selectedHabit.id}`,
        {
          title: selectedHabit.title,
          start_time: selectedHabit.start_time,
          end_time: selectedHabit.end_time,
          completed: selectedHabit.completed,
        },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      await fetchHabits();
      closeModal();
    } catch (err) {
      console.error("Error updating habit:", err);
      alert("Error updating habit.");
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Are you sure you want to delete this habit?")) return;
    try {
      await axios.delete(`http://127.0.0.1:8000/habits/${id}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      await fetchHabits();
    } catch (err) {
      console.error("Error deleting habit:", err);
    }
  };

  const Modal = () => {
    if (!showModal || !selectedHabit) return null;
    return ReactDOM.createPortal(
      <div
        className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"
        onClick={closeModal}
      >
        <div
          className="bg-white p-6 rounded-lg shadow-lg w-96 relative"
          onClick={(e) => e.stopPropagation()}
        >
          <h3 className="text-lg font-semibold mb-3 text-center">Edit Habit</h3>

          <label className="block text-sm mb-1">Title</label>
          <input
            type="text"
            value={selectedHabit.title}
            onChange={(e) =>
              setSelectedHabit({ ...selectedHabit, title: e.target.value })
            }
            className="w-full mb-3 border rounded p-2"
          />

          <label className="block text-sm mb-1">Start Time</label>
          <input
            type="datetime-local"
            value={selectedHabit.start_time?.replace(" ", "T").slice(0, 16)}
            onChange={(e) =>
              setSelectedHabit({
                ...selectedHabit,
                start_time: e.target.value,
              })
            }
            className="w-full mb-3 border rounded p-2"
          />

          <label className="block text-sm mb-1">End Time</label>
          <input
            type="datetime-local"
            value={selectedHabit.end_time?.replace(" ", "T").slice(0, 16)}
            onChange={(e) =>
              setSelectedHabit({
                ...selectedHabit,
                end_time: e.target.value,
              })
            }
            className="w-full mb-3 border rounded p-2"
          />

          <div className="flex items-center mb-4">
            <input
              type="checkbox"
              checked={selectedHabit.completed}
              onChange={(e) =>
                setSelectedHabit({
                  ...selectedHabit,
                  completed: e.target.checked,
                })
              }
              className="mr-2"
            />
            <label>Mark as Completed</label>
          </div>

          <div className="flex justify-between">
            <button
              onClick={handleSave}
              className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
            >
              Save
            </button>
            <button
              onClick={() => handleDelete(selectedHabit.id)}
              className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
            >
              Delete
            </button>
            <button
              onClick={closeModal}
              className="bg-gray-400 text-white px-4 py-2 rounded hover:bg-gray-500"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>,
      document.body
    );
  };

  return (
    <div className="min-h-0">
      <h2 className="text-2xl font-semibold mb-4">📋 Recent Habits</h2>

      <div className="h-56 overflow-y-auto pr-2 custom-scrollbar min-h-[14rem]">
        <ul className="space-y-3">
          {habits.length === 0 ? (
            <p className="text-gray-500">No habits yet.</p>
          ) : (
            habits.map((h) => (
              <li
                key={h.id}
                onClick={() => openEditModal(h)}
                className={`cursor-pointer p-3 rounded-lg border transition ${
                  h.completed
                    ? "bg-green-100 border-green-400 hover:bg-green-200"
                    : "bg-red-100 border-red-400 hover:bg-red-200"
                }`}
              >
                <div className="flex justify-between items-center">
                  <span className="font-medium">{h.title}</span>
                  <span className="text-gray-600 text-sm">
                    {formatDateRange(h.start_time, h.end_time)}
                  </span>
                </div>
              </li>
            ))
          )}
        </ul>
      </div>

      <Modal />
    </div>
  );
}
