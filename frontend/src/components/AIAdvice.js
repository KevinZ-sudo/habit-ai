import React, { useEffect, useState } from "react";
import axios from "axios";

export default function AIAdvice() {
  const [text, setText] = useState("Loading...");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchAdvice = async () => {
      try {
        const token = localStorage.getItem("token");
        if (!token) {
          setText("You are not logged in.");
          setLoading(false);
          return;
        }

        const me = await axios.get("http://127.0.0.1:8000/auth/me", {
          headers: { Authorization: `Bearer ${token}` },
        });
        const userId = me.data.id;

        const res = await axios.get(
          `http://127.0.0.1:8000/ai/suggestion/${userId}`
        );

        setText(res.data?.suggestion || "No suggestion available.");
      } catch (err) {
        console.error(err);
        setText("Failed to load AI advice. Please try again later.");
      } finally {
        setLoading(false);
      }
    };

    fetchAdvice();
  }, []);

  return (
    <div className="w-full">
      {/* Title */}
      <div className="flex items-center mb-3">
        <span className="text-3xl mr-2">🤖</span>
        <h2 className="text-2xl font-semibold text-gray-800">
          AI Recommendation
        </h2>
      </div>

      {/* Main text */}
      <p className="text-gray-800 text-lg leading-relaxed font-medium italic">
        {loading ? "Loading..." : `“${text}”`}
      </p>

      {/* Hint */}
      <div className="mt-4 text-sm text-gray-500 italic">
        💡 Stay consistent — small steps each day lead to big change.
      </div>
    </div>
  );
}
