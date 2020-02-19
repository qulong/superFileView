class JsonBeanLoginEntity {
	bool result;
	dynamic errcode;
	String msg;
	dynamic data;

	JsonBeanLoginEntity({this.result, this.errcode, this.msg, this.data});

	JsonBeanLoginEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'];
		errcode = json['errcode'];
		msg = json['msg'];
		data = (json['data'] != null &&json['data'] != "")? new JsonBeanLoginData.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['result'] = this.result;
		data['errcode'] = this.errcode;
		data['msg'] = this.msg;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		return data;
	}
}

class JsonBeanLoginData {
	String outId;

	JsonBeanLoginData({this.outId});

	JsonBeanLoginData.fromJson(Map<String, dynamic> json) {
		outId = json['outId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['outId'] = this.outId;
		return data;
	}
}
