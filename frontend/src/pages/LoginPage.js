import React, { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import axios from "axios";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post(
        "http://127.0.0.1:8000/auth/token",
        new URLSearchParams({
          username: email,
          password: password,
        }),
        {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        }
      );

      const token = response.data.access_token;
      localStorage.setItem("token", token);

      const profileRes = await axios.get("http://127.0.0.1:8000/auth/me", {
        headers: { Authorization: `Bearer ${token}` },
      });

      const profile = profileRes.data;

      const userPayload = {
        username: profile.username || profile.name || email.split("@")[0],
        email: profile.email || email,
      };

      localStorage.setItem("user", JSON.stringify(userPayload));

      navigate("/dashboard");
    } catch (error) {
      alert("Invalid credentials");
    }
  };

  return (
    <div className="flex justify-center items-center min-h-screen bg-gradient-to-br from-indigo-50 to-blue-100">
      <div className="bg-white shadow-2xl rounded-2xl p-10 w-full max-w-lg border border-gray-200">
        <h1 className="text-3xl font-bold text-center text-blue-700 mb-10">
          Login to Habit-AI
        </h1>

        <form onSubmit={handleLogin} className="flex flex-col items-center space-y-8">
          <div className="w-11/12">
            <label
              htmlFor="email"
              className="block text-sm font-medium text-gray-700 mb-2 ml-1"
            >
              Email
            </label>
            <input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none placeholder-gray-400"
              placeholder="Enter your email"
              required
            />
          </div>

          <div className="w-11/12">
            <label
              htmlFor="password"
              className="block text-sm font-medium text-gray-700 mb-2 ml-1"
            >
              Password
            </label>
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none placeholder-gray-400"
              placeholder="Enter your password"
              required
            />
          </div>

          <button
            type="submit"
            className="w-11/12 bg-blue-600 text-white font-semibold py-2 rounded-lg hover:bg-blue-700 transition duration-200"
          >
            Login
          </button>
        </form>

        <p className="text-center text-sm text-gray-600 mt-8">
          No account yet?{" "}
          <Link
            to="/register"
            className="text-blue-600 font-semibold hover:underline"
          >
            Register
          </Link>
        </p>
      </div>
    </div>
  );
}
