import React, { useEffect, useState } from "react";

// import components
import TestiSlider from "./TestiSlider";

const Testimonials = () => {
  return (
    <section id="testimonials" className="section bg-secondary">
      <div className="container mx-auto">
        <div className="flex flex-col items-center text-center">
          <h2 className="section-title  relative before:absolute before:opacity-40 before:-top-[2rem] before:-left-64 before:hidden before:lg:block">
            What are the goals world3 seeks to solve with web3
          </h2>
          <p className="subtitle">
            Below are description of how world3 want to solve SDG Goal 1 , 13,
            14, 15
          </p>
        </div>
        <TestiSlider />
      </div>
    </section>
  );
};

export default Testimonials;
