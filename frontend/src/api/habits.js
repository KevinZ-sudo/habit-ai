import api from "./axios";

export const getHabits = async () => {
  const token = localStorage.getItem("token");
  const res = await api.get("/habits/", {
    headers: { Authorization: `Bearer ${token}` },
  });
  return res.data;
};

export const createHabit = async (data) => {
  const token = localStorage.getItem("token");
  const res = await api.post("/habits/", data, {
    headers: { Authorization: `Bearer ${token}` },
  });
  return res.data;
};
