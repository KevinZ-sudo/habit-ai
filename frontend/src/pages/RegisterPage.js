import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";

export default function RegisterPage() {
  const [email, setEmail] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate();

  const handleRegister = async (e) => {
    e.preventDefault();
    try {
      // ✅ 向后端真实路径 /auth/register 发送 POST 请求
      const res = await axios.post("http://127.0.0.1:8000/auth/register", {
        email,
        username,
        password,
      });

      if (res.status === 200 || res.status === 201) {
        alert("Registration successful! Please log in.");
        navigate("/"); // 注册成功后跳转到登录页
      }
    } catch (err) {
      console.error("Registration failed:", err);

      if (err.response && err.response.data && err.response.data.detail) {
        alert("Error: " + err.response.data.detail);
      } else {
        alert("Registration failed. Please try again.");
      }
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-100 to-gray-200">
      <div className="bg-white/90 backdrop-blur-sm p-8 rounded-2xl shadow-lg w-96 border border-gray-200">
        <h2 className="text-2xl font-bold mb-6 text-center">Register Account</h2>

        <form onSubmit={handleRegister} className="space-y-4">
          <input
            type="text"
            placeholder="Username"
            className="w-full p-2 border rounded-lg focus:ring focus:ring-blue-300"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
          />
          <input
            type="email"
            placeholder="Email"
            className="w-full p-2 border rounded-lg focus:ring focus:ring-blue-300"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
          <input
            type="password"
            placeholder="Password"
            className="w-full p-2 border rounded-lg focus:ring focus:ring-blue-300"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />

          <button
            type="submit"
            className="w-full bg-green-500 hover:bg-green-600 text-white font-semibold py-2 rounded-lg shadow"
          >
            Register
          </button>
        </form>

        <p className="text-sm text-center text-gray-500 mt-4">
          Already have an account?{" "}
          <Link to="/" className="text-blue-500 hover:underline">
            Login
          </Link>
        </p>
      </div>
    </div>
  );
}
