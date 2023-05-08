import React, { useState } from "react";
import { useHistory } from 'react-router-dom';
import LogoImage from '../images/LOGO_A.png';
import axios from "axios";

export default function OpenStore(props) {
	let urltoken = props.match.params.token;
	let account = props.match.params.account;

	const history = useHistory();

	const [store] = useState({
		resturant_account: account
	});

	console.log(urltoken);
	console.log(account);

	// const [token] = useState({
	// 	token: urltoken
	// })

	axios.defaults.headers.common['Authorization'] = `Bearer ${urltoken}`;


	const handleOpen = async (e) => {
		try {
			console.log(store);
			const response = await axios.post('http://127.0.0.1:8000/api/openStore', store); // 替換為實際的後端 API URL

			console.log(response.data);
			if (response.data.status === true) {
				alert('開通成功 請登入');
				history.push('/login');
			}

		} catch (error) {
			console.error(error);
		}
	}

	handleOpen();

	// const handleResetChange = (e) => {
	//   const { name, value } = e.target;
	//   setReset({ ...reset, [name]: value });
	// }



	// useEffect(()=>{
	// setToken({token: urltoken})
	// console.log(urltoken);
	// })


	return (
		<React.Fragment>
			<section>
				<section>
					<nav className="navbar fixed-top bg-white">
						<div className="container-fluid">
							<a href="/index" className="px-3 py-3">
								<img
									className=""
									src={LogoImage}
									style={{ width: "250px" }}
									alt="logo" />
							</a>
							<div
								id="navSh"
								style={{ display: "none" }}
								className="w-50">
								<div className="bg-width border border-dark rounded-1 py-2">
									<div className="row align-items-center justify-content-between">
										<div className="col-1 ms-3">
											<svg
												xmlns="http://www.w3.org/2000/svg"
												width="30"
												height="30"
												fill="currentColor"
												className="bi bi-shop"
												viewBox="0 0 16 16">
												<path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zM4 15h3v-5H4v5zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-3zm3 0h-2v3h2v-3z" />
											</svg>
										</div>
									</div>
								</div>
							</div>
							<div className="d-flex">
								<a className="btn btn-light border-dark rounded-pill ms-2 me-3 rgsBtn d-flex align-items-center" href="/register">
									<div
										className="d-block mx-auto my-2 d-flex align-items-center"
										width="20"
										height="20">
										<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-unlock-fill" viewBox="0 0 16 16">
											<path d="M11 1a2 2 0 0 0-2 2v4a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h5V3a3 3 0 0 1 6 0v4a.5.5 0 0 1-1 0V3a2 2 0 0 0-2-2z" />
										</svg>
										<span className="mx-1 ">
											開通中
										</span>
									</div>
								</a>
							</div>
						</div>
					</nav>
				</section>
			</section>
			<section style={{ marginTop: "350px" }}>
				<div className="container" >
					<div className="row m-0 m-auto border rounded p-5 justify-content-center border-secondary col-12 col-md-8 col-lg-6" >
						<ul className="nav nav-tabs d-flex justify-content-around" id="myTab" role="tablist">
							<li className="nav-item" role="presentation">
								<button className="nav-link px-5 fs-4 active" id="registerform" data-bs-toggle="tab" data-bs-target="#registerform-pane" type="button">開通帳號中</button>
							</li>
						</ul>
						<div className="tab-content container row m-0" id="myTabContent">
							<div className="tab-pane fade show active" id="registerform-pane" role="tabpanel" aria-labelledby="registerform" tabIndex="0">
								<form method="post">
									<div class="d-flex align-items-center px-5 mt-3 justify-content-center" id="loading">
										<p className="fs-2 mb-0">系統處理中...</p>
										<div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
									</div>
								</form>
							</div>
						</div>

					</div>
				</div>
			</section>
		</React.Fragment>

	)
}

