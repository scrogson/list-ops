defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  # 
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically important`) and so shouldn't be used either.
 
  @spec count(list) :: non_neg_integer
  def count(list), do: _count(list, 0)

  defp _count([], acc), do: acc
  defp _count([_h|t], acc), do: _count(t, acc + 1)

  @spec reverse(list) :: list
  def reverse(list), do: _reverse(list, [])

  defp _reverse([], acc), do: acc
  defp _reverse([h|t], acc), do: _reverse(t, [h|acc])

  @spec map(list, (any -> any)) :: list
  def map(list, func), do: _map(list, func, [])

  defp _map([], _func, acc), do: acc |> reverse
  defp _map([h|t], func, acc), do: _map(t, func, [func.(h)|acc])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, func), do: _filter(list, func, [])

  defp _filter([], _func, acc), do: acc |> reverse
  defp _filter([h|t], func, acc) do
    if func.(h) do
      _filter(t, func, [h|acc])
    else
      _filter(t, func, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h|t], acc, func), do: reduce(t, func.(h, acc), func)

  @spec append(list, list) :: list
  def append(list, acc), do: _append(reverse(list), acc)

  defp _append([], acc), do: acc
  defp _append([h|t], acc), do: _append(t, [h|acc])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: reverse(ll) |> reduce([], &(append(&1, &2)))
end
