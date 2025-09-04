"use client";

import { useEffect, useState } from "react";

type Todo = { _id: string; title: string; completed: boolean };

const API = process.env.NEXT_PUBLIC_API_URL!;

export default function Home() {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [title, setTitle] = useState("");
  const [loading, setLoading] = useState(false);

  const load = async () => {
    const res = await fetch(`${API}/api/todos`, { cache: "no-store" });
    setTodos(await res.json());
  };

  useEffect(() => { load(); }, []);

  const addTodo = async () => {
    if (!title.trim()) return;
    setLoading(true);
    await fetch(`${API}/api/todos`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title })
    });
    setTitle("");
    setLoading(false);
    load();
  };

  const toggle = async (id: string, done: boolean) => {
    await fetch(`${API}/api/todos/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ completed: !done })
    });
    load();
  };

  const remove = async (id: string) => {
    await fetch(`${API}/api/todos/${id}`, { method: "DELETE" });
    load();
  };

  return (
    <main className="min-h-dvh mx-auto max-w-xl p-6">
      <h1 className="text-2xl font-semibold mb-4">Todos</h1>

      <div className="flex gap-2 mb-6">
        <input
          className="flex-1 border rounded px-3 py-2"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Add a task…"
          onKeyDown={(e) => e.key === "Enter" && addTodo()}
        />
        <button
          onClick={addTodo}
          disabled={loading}
          className="px-4 py-2 rounded bg-black text-white disabled:opacity-50"
        >
          Add
        </button>
      </div>

      <ul className="space-y-2">
        {todos.map((t) => (
          <li key={t._id} className="flex items-center justify-between border rounded px-3 py-2">
            <button onClick={() => toggle(t._id, t.completed)} className="flex items-center gap-3">
              <input type="checkbox" readOnly checked={t.completed} />
              <span className={t.completed ? "line-through text-gray-500" : ""}>{t.title}</span>
            </button>
            <button onClick={() => remove(t._id)} className="text-red-600">Delete</button>
          </li>
        ))}
      </ul>
    </main>
  );
}
