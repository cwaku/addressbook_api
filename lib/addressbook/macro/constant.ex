# defmodule Addressbook.Macro do
#   defmacro const(name, value) do
#     quote do
#       @doc "Constant #{unquote(name)}"
#       def unquote(:"#{name}")(), do: unquote(value)
#     end
#   end
# end
