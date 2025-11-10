const BASE_URL = "http://127.0.0.1:8000";

export const getHabits = async (token) => {
  const res = await fetch(`${BASE_URL}/habits`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  return res.json();
};

export const createHabit = async (token, habit) => {
  const res = await fetch(`${BASE_URL}/habits`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(habit),
  });
  return res.json();
};

export const updateHabit = async (token, id, data) => {
  const res = await fetch(`${BASE_URL}/habits/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(data),
  });
  return res.json();
};

export const deleteHabit = async (token, id) => {
  await fetch(`${BASE_URL}/habits/${id}`, {
    method: "DELETE",
    headers: { Authorization: `Bearer ${token}` },
  });
};
