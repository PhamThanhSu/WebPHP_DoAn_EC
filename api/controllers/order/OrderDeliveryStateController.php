<?php

class OrderDeliveryStateController extends ErrorHandler {
    public function __construct(private OrderDeliveryStateGateway $gateway, private Auths $auths) {}

    public function processRequest(string $method, ?int $id, ?int $limit, ?int $offset): void {
       if($id){
        $this->processResourceRequest($method, $id);
        return;
       }
       $this->processCollectionRequest($method, $limit, $offset);
    }
    private function processResourceRequest(string $method, ?int $id): void {
        $delivery_state = $this->gateway->get($id);
        if(!$delivery_state){
            $this->sendErrorResponse(404, "Delivery state with an id $id not found");
            return;
        }
        switch($method){
            case "GET":
                echo json_encode([
                    "success" => true,
                    "data" => $delivery_state
                ]);
                break;
            case "PUT":
                $this->auths->verifyAction("UPDATE_DELIVERY_STATE");
                $data = (array) json_decode(file_get_contents("php://input"));
                $errors = $this->getValidationErrors($data, false);
                if(!empty($errors)){
                    $this->sendErrorResponse(422, $errors);
                    break;
                }
                $data = $this->gateway->update($delivery_state, $data);
                echo json_encode([
                    "success" => true,
                    "message" => "Delivery state id $id updated",
                    "data" => $data
                ]);
                break;
            case "DELETE":
                $this->auths->verifyAction("DELETE_DELIVERY_STATE");
                $res = $this->gateway->delete($id);
                echo json_encode([
                    "success" => $res,
                    "message" => "Delivery state id $id was deleted"
                ]);
                break;
            default:
                $this->sendErrorResponse(405, "only allow GET, PUT, DELETE method");
                header("Allow: GET, PUT, DELETE");
        }
    }
    public function processCollectionRequest(string $method, ?int $limit, ?int $offset): void {
        switch ($method) {
            case "GET":
                $data = $this->gateway->getAll($limit, $offset);
                echo json_encode([
                    "success" => true,
                    "data" => $data
                ]);
                break;
            case "POST":
                $this->auths->verifyAction("CREATE_DELIVERY_STATE");
                $data = (array) json_decode(file_get_contents("php://input"));
                $errors = $this->getValidationErrors($data);
                if(!empty($errors)){
                    $this->sendErrorResponse(422, $errors);
                    break;
                }
                $data = $this->gateway->create($data);
                http_response_code(201);
                echo json_encode(["susses" => true,
                    "message" => "Delivery state created",
                    "data" => $data
                ]);
                break;
            default:
                $this->sendErrorResponse(405, "only allow GET, POST method");
                header("Allow: GET, POST");
        }
    }
    private function getValidationErrors(array $data, bool $new_delivery_state=true): array {
        $errors = [];
        if($new_delivery_state){ //check all fields for new_delivery_state
            if(empty($data["name"])) $errors[] = "name is required"; 
        } else { //check fields that exist
            if(array_key_exists($data["name"], $data) && empty($data["name"])) $errors[] = "name is required";
        }
        return $errors;
    }
}