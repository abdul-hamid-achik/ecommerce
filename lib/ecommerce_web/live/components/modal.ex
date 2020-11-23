defmodule EcommerceWeb.Components.Modal do
  @moduledoc """
  This is a general modal component with a title, body text, and either
  one or two buttons. Many aspects of the modal can be customized, including
  colors, button labels, and title and body text. Application wide defaults
  are specified for the colors and button texts.

  A required action string and optional parameter are provided for each
  button when the modal is initialized. These will be returned to the caller
  when the corresponding button is clicked.

  The caller must have message handlers defined for each button that takes
  the given action and parameter for each button. For example:

    def handle_info(
        {ModalComponent, :button_pressed,
         %{action: "remove-item-confirmed", param: display_order_of_item}},
        socket
      )

  Also, the caller should have a 'modal_closed' event handler that will be called when the
  modal is closed with a click-away or escape key press.

    def handle_info(
        {ModalComponent, :modal_closed, %{id: "confirm-heading-removal"}},
        socket
      ) do

  This is a stateful component, so you MUST specify an id when calling
  live_component.

  The display of the modal is determined by the required show assign.

  The component can be called like:

  <%= live_component(@socket, ModalComponent,
      id: "confirm-delete-member",
      show: @live_action == :delete_member,
      title: "Delete Member",
      body: "Are you sure you want to delete team member?",
      right_button: "Delete",
      right_button_action: "delete-member",
      left_button: "Cancel",
      left_button_action: "cancel-delete-member")
  %>
  """

  use EcommerceWeb, :live_component
  import Process, only: [send_after: 3]

  @defaults %{
    show: false,
    enter_duration: 300,
    leave_duration: 200,
    background_color: "bg-gray-500",
    background_opacity: "opacity-75",
    title_color: "text-gray-900",
    body_color: "text-gray-500",
    left_button: nil,
    left_button_action: nil,
    left_button_param: nil,
    right_button: nil,
    right_button_color: "red",
    right_button_action: nil,
    right_button_param: nil
  }

  @impl Phoenix.LiveComponent
  def mount(socket) do
    {:ok, assign(socket, @defaults)}
  end

  @impl Phoenix.LiveComponent
  def handle_event("modal-closed", _params, socket) do
    # Handle event fired from Modal hook leave_duration-milliseconds
    # afer open transitions to false.
    send(self(), {__MODULE__, :modal_closed, %{id: socket.assigns.id}})

    {:noreply, socket}
  end

  # Fired when user clicks right button on modal
  def handle_event(
        "right-button-click",
        _params,
        %{
          assigns: %{
            right_button_action: right_button_action,
            right_button_param: right_button_param,
            leave_duration: leave_duration
          }
        } = socket
      ) do
    send(
      self(),
      {__MODULE__, :button_pressed, %{action: right_button_action, param: right_button_param}}
    )

    send_after(self(), {__MODULE__, :modal_closed, %{id: socket.assigns.id}}, leave_duration)

    {:noreply, socket}
  end

  def handle_event(
        "left-button-click",
        _params,
        %{
          assigns: %{
            left_button_action: left_button_action,
            left_button_param: left_button_param,
            leave_duration: leave_duration
          }
        } = socket
      ) do
    send(
      self(),
      {__MODULE__, :button_pressed, %{action: left_button_action, param: left_button_param}}
    )

    send_after(self(), {__MODULE__, :modal_closed, %{id: socket.assigns.id}}, leave_duration)

    {:noreply, socket}
  end
end
